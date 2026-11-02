import importlib
import unittest

def moduleExists(module):
    try:
        importlib.import_module(module)
    except:
        return False
    else:
        return True

def skipUnlessModulesPresent(*modules):
    missing = [m for m in modules if not moduleExists(m)]

    return unittest.skipIf(
        bool(missing),
        f"Missing modules : {', '.join(missing)}"
    )

