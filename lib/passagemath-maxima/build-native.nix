{
  fetchPypi,
  buildPythonPackage,
  cysignals,
  pexpect,
  passagemath-environment,
  passagemath-ecl,
  passagemath-categories,
  pkgs,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-maxima";
  version = "10.8.13";

  pyproject = true;
  build-system = [
    setuptools
    passagemath-setup
    pkgconfig
    passagemath-categories
    cython
    cysignals
  ];
  nativeBuildInputs = with pkgs; [
    ecl
  ];
  buildInputs = with pkgs; [
    # No additional system libraries are required.
  ];
  dependencies = [
    pexpect
    passagemath-ecl
    passagemath-environment
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_maxima";
    inherit version;
    hash = "sha256-q7ITA6g3cc4Xo+l68cGIKMN3Xqkcr5gHOFCKGIJSUzg=";
  };
}
