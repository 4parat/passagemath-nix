{
  pkgs,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,
  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  cysignals,
  passagemath-graphs,
  ...
}:
buildPythonPackage rec {
  pname = "passagemath-nauty";
  version = "10.8.13";

  pyproject = true;
  build-system = [ setuptools cython pkgconfig passagemath-setup passagemath-environment ];
  buildInputs = with pkgs; [
    nauty
  ];
  dependencies = [
    cysignals
    passagemath-environment
    passagemath-graphs
  ];

  postPatch = ''
    sed -i '/passagemath-conf ~= .* ; sys_platform !=/d' pyproject.toml
  '';

  src = fetchPypi {
    pname = "passagemath_nauty";
    inherit version;
    hash = "sha256-ms6j8BtS+C075RxbmI50OQ3roarQJWRMD6EZXpkOVHA=";
  };
}
