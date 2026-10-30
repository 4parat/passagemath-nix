import unittest
import shutil
import os
import pkgconfig

from sage.all import GF, Graph, PolynomialRing, QQ, ZZ, factor, matrix
from IPython.terminal.interactiveshell import TerminalInteractiveShell

class CythonTests(unittest.TestCase):
    def test_info_cython(self):
        print("Executable:", shutil.which("pkg-config"))
        print("PKG_CONFIG_PATH:", os.environ.get("PKG_CONFIG_PATH"))
        print("Python pkgconfig:", pkgconfig.exists("fflas-ffpack"))


    def test_cython(self):
        ip = TerminalInteractiveShell.instance()
        ip.run_line_magic("load_ext", "sage.repl.ipython_extension")
        ip.run_cell_magic("cython", "", """
cdef int x = 42
print(x)
""")

if __name__ == "__main__":
    unittest.main()


