/*
  This is just a wrapper to buildPythonPackage.
  It gives the possibility to write to _sage_conf/<spkg_name>.py, which will be read by
  the passagemath-conf-nix implementation.

  For instance, passagemath-gap will write where to find gap, and passagemath packages depending on passagemath-gap,
  such as passagemath-groups will find gap using the _sage_conf/passagemath-gap.py module defining it.
  So the runtime flow is this one:
    - passagemath-groups need gap somewhere
    - Since passagemath-gap is a dependency of passagemath-groups, _sage_conf/passagemath-gap.py exists.
    - passagemath-groups will at some point: 
        - call sage.env.var("GAP_ROOT_PATH")
        - which will call sage.config.GAP_ROOT_PATHS (if no environment variable named GAP_ROOT_PATHS exist)
        - which is defined via _sage_conf.__main__.py
        - _sage_conf.__main__ aggregates definitions in all _sage_conf/ files, and therefor in _sage_conf/passagemath-gap.py
        - _sage_conf/passagemath-gap.py contains the actual definition of GAP_ROOT_PATHS, which is piloted by nix.
        If I get it right
  
  This means we don't rely on ugly environment variables that the user should be forced to define in his env definition.
  This also mean we dont rely on fragile runtime variables (which, w.h.p, also uses environment variables or common install pathes)


  This wrapper adds the 'sageConf' field to `buildPythonPackages`, which produces actual python code.
  This might be a security issue, even if the data isn't raw python.
  We should keep using buildPythonPackages when we dont have to add variables to the configuration.
*/
{
  lib,
  buildPythonPackage,
  python,
  writeText,
}:

{
  sageConf ? {},
  ...
}@args:

let
  sageConfModule = lib.replaceStrings [ "-" ] [ "_" ] args.pname;
  hasSageConf = sageConfModule != null && sageConf != {};

  # Sérialisation récursive des valeurs Nix via JSON.
  configFile = writeText "${sageConfModule}-config.py" ''
    import json
    globals().update(
        json.loads(${builtins.toJSON (builtins.toJSON sageConf)})
    )
  '';

  packageArgs = removeAttrs args [
    "sageConfModule"
    "sageConf"
  ];
in

buildPythonPackage (packageArgs // {
  postInstall = (args.postInstall or "") + lib.optionalString hasSageConf ''
    mkdir -p "$out/${python.sitePackages}/_sage_conf"

    cp ${configFile} \
      "$out/${python.sitePackages}/_sage_conf/${sageConfModule}.py"
  '';
})
