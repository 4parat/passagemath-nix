#!/usr/bin/env python3
"""Compare evaluated Python closures with the requirements in pinned archives.

Usage (from the repository root, with Python's packaging module available):
  nix eval --impure --json .#pkgs.x86_64-linux \
    --apply 'import ./.scripts/dependency-matrix.nix' > /tmp/dependencies.json
  python .scripts/check-dependencies.py /tmp/dependencies.json

Missing source archives are reported as unverified, never as successes.
"""

import argparse
import email
import json
import re
import tarfile
import tomllib
import zipfile
from functools import cache
from pathlib import Path

from packaging.markers import default_environment
from packaging.requirements import Requirement
from packaging.specifiers import SpecifierSet
from packaging.utils import canonicalize_name


def normalize(name):
    return canonicalize_name(re.sub(r"^python3\.\d+-", "", name))


@cache
def read_metadata(path):
    if path.endswith(".whl"):
        with zipfile.ZipFile(path) as archive:
            metadata = archive.read(next(
                name for name in archive.namelist()
                if name.endswith(".dist-info/METADATA")
            ))
        project = {}
    else:
        with tarfile.open(path) as archive:
            root_files = {
                Path(member.name).name: member
                for member in archive.getmembers()
                if member.isfile() and member.name.count("/") == 1
            }
            metadata = archive.extractfile(root_files["PKG-INFO"]).read()
            project = (
                tomllib.loads(archive.extractfile(root_files["pyproject.toml"]).read().decode())
                if "pyproject.toml" in root_files else {}
            )
    message = email.message_from_bytes(metadata)
    return message.get_all("Requires-Dist", []), message["Requires-Python"], project


def check_variant(variant, packages):
    interpreter_version = next(
        dependency["version"]
        for dependency in packages[0]["buildClosure"]
        if dependency["name"] == "python3"
    )
    environment = default_environment() | {
        "python_version": ".".join(interpreter_version.split(".")[:2]),
        "python_full_version": interpreter_version,
        "implementation_version": interpreter_version,
        "sys_platform": "linux",
        "platform_system": "Linux",
        "platform_machine": "x86_64",
        "extra": "",
    }
    errors, unavailable, additions = [], [], []
    checked = 0
    for package in packages:
        label = f"{variant}/{package['name']}"
        if not Path(package["src"]).is_file():
            unavailable.append(label)
            continue
        runtime, requires_python, project = read_metadata(package["src"])
        checked += 1
        if requires_python and not SpecifierSet(requires_python).contains(environment["python_full_version"]):
            errors.append(f"{label}: Requires-Python {requires_python}")
        runtime_closure = {normalize(p["name"]): p for p in package["runtimeClosure"]}
        build_closure = {normalize(p["name"]): p for p in package["buildClosure"]}
        removed = {normalize(n) for n in package["remove"]}
        relaxed = {normalize(n) for n in package["relax"]}
        # These expressions remove the sage-conf bootstrap requirement in pyproject.toml.
        if "sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml" in package["postPatch"]:
            removed.add("passagemath-conf")
        required_runtime = set()
        for phase, requirements, closure in [
            ("runtime", runtime, runtime_closure),
            ("build", project.get("build-system", {}).get("requires", []), build_closure),
        ]:
            for text in requirements:
                requirement = Requirement(text)
                name = normalize(requirement.name)
                if name in removed or (requirement.marker and not requirement.marker.evaluate(environment)):
                    continue
                if phase == "runtime":
                    required_runtime.add(name)
                if name not in closure:
                    errors.append(f"{label}: {phase} missing {requirement}")
                elif name not in relaxed and not requirement.specifier.contains(closure[name]["version"], prereleases=True):
                    errors.append(f"{label}: {phase} requires {requirement}, found {closure[name]['version']}")
        for dependency in package["dependencies"]:
            name = normalize(dependency["name"])
            if name not in required_runtime:
                additions.append(f"{label}: additional runtime dependency {name}")
    print(f"{variant}: {checked}/{len(packages)} archives checked, {len(errors)} errors, {len(additions)} runtime additions")
    return errors, unavailable, additions


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("matrix", type=Path)
    parser.add_argument("--require-all-sources", action="store_true")
    args = parser.parse_args()
    errors, unavailable, additions = [], [], []
    for variant, packages in json.loads(args.matrix.read_text()).items():
        variant_errors, variant_unavailable, variant_additions = check_variant(variant, packages)
        errors.extend(variant_errors)
        unavailable.extend(variant_unavailable)
        additions.extend(variant_additions)
    for line in errors + additions:
        print(line)
    for label in unavailable:
        print(f"UNVERIFIED (source archive absent): {label}")
    # An addition needs review, but may fix incomplete upstream metadata (cliquer).
    return 1 if errors or (args.require_all_sources and unavailable) else 0


if __name__ == "__main__":
    raise SystemExit(main())
