{ buildPythonPackage, fetchPypi, 
  passagemath-symbolics,
... }:

buildPythonPackage rec {
  pname = "passagemath-standard";
  version = "10.8.13";
  format = "wheel";

  src = fetchPypi {
    pname = "passagemath_standard";
    inherit version format;

    sha256 = "2f8fcc54dea3703c02e0613c9bf84861858732b42bf366e55c7e9cad19256afa";

    dist = "py3";
    python = "py3";
    abi = "none";
    platform = "any";
  };

  dependencies = [
  ];
}

