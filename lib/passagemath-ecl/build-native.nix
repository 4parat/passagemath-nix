{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  memory-allocator,
  cysignals,
  pexpect,
  passagemath-categories,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-ecl";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  nativeBuildInputs = with pkgs; [
    ecl
  ];
  buildInputs = with pkgs; [
    ecl
    gmp
    libffi
  ];
  dependencies = [
    memory-allocator
    cysignals
    pexpect
    passagemath-environment
    passagemath-categories
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_ecl";
    inherit version;
    hash = "sha256-BD6+7oPJpChvy6UFVMfMG6wa0ZQDzaIn0cuW9+2ExsU=";
  };
}
