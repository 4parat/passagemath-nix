{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  cython,

  pkgconfig,
  passagemath-setup,
  passagemath-environment,
  ...
}:
let 
  pname = "passagemath-conf";
  snake_pname = "passagemath_conf";
  version = "10.8.13";
  hash = "sha256-luuD+ARdXzSZx93UttZBUr9vjYlXhfkIfH5HUBRRRRg=";
in
  buildPythonPackage rec {
    inherit pname version;

    pyproject = true;

    env.SAGE_CONF_FILE = "/dev/null";
    build-system = [
        setuptools
    ];

    src = fetchPypi {
      pname = snake_pname;
      inherit version hash;
    };
  }

