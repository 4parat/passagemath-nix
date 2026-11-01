{
  fetchPypi,
  buildPythonPackage,
  passagemath-environment,
  ...
}:
buildPythonPackage {
  pname = "passagemath-gap-pkg-tomlib-data";
  version = "10.8.13";
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_gap_pkg_tomlib_data";
    version = "10.8.13";
    format = "wheel";
    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
    hash = "sha256-NvSgq2BsIS/yubzga/kmdm1WNbI36Re5Ql781kBXkX0=";
  };

  dependencies = [ passagemath-environment ];
}
