import unittest
from testsutils import skipUnlessModulesPresent


class SageFeatureTests(unittest.TestCase):
    def test_000_no_additional_features(self):
        from passagemath_polyhedra import Polyhedron
        P = Polyhedron(ieqs=[
            [0, 1, 0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 1],
            [0, 0, 1, -1, -1, 1, 0],
            [0, 0, -1, 1, -1, 1, 0]],
        eqns=[[-31, 1, 1, 1, 1, 1, 1]])

        self.assertEqual(repr(P), "A 5-dimensional polyhedron in QQ^6 defined as the convex hull of 7 vertices")
        
        self.assertEqual(repr(P.Vrepresentation()),
          " ".join(["(A vertex at (31, 0, 0, 0, 0, 0),",
          "A vertex at (0, 0, 0, 0, 0, 31),",
          "A vertex at (0, 0, 0, 0, 31, 0),",
          "A vertex at (0, 0, 31/2, 0, 31/2, 0),",
          "A vertex at (0, 31/2, 31/2, 0, 0, 0),",
          "A vertex at (0, 31/2, 0, 0, 31/2, 0),",
          "A vertex at (0, 0, 0, 31/2, 31/2, 0))"]))

    @skipUnlessModulesPresent("passagemath_graphs")
    def test_001_additional_features_graph(self):
        from passagemath_polyhedra import Polyhedron
        try:
            c5_10 = Polyhedron(vertices = [[i, i**2, i**3, i**4, i**5] for i in range(1, 11)]);
            self.assertEqual(repr(c5_10), "A 5-dimensional polyhedron in ZZ^5 defined as the convex hull of 10 vertices")
            c5_10_fl = c5_10.face_lattice()
            self.assertEqual(repr([len(x) for x in c5_10_fl.level_sets()]), "[1, 10, 45, 100, 105, 42, 1]")
        except ImportError:
            pass


    @skipUnlessModulesPresent("passagemath_groups", "passagemath_graphs")
    def test_002_additional_features_graph_groups(self):
        from sage.all import polytopes
        try:
            P24 = polytopes.twenty_four_cell()
            self.assertEqual(repr(P24), "A 4-dimensional polyhedron in QQ^4 defined as the convex hull of 24 vertices")

            AutP24 = P24.restricted_automorphism_group()
            self.assertEqual(AutP24.order(), 1152)
        except ImportError:
            pass


    @skipUnlessModulesPresent("sage.torics")
    def test_003_additional_features_torics(self):
        from passagemath_polyhedra import Polyhedron
        from sage.all import ToricVariety, NormalFan, lattice_polytope
        try:
            TV3 = ToricVariety(NormalFan(lattice_polytope.cross_polytope(3)))
            self.assertEqual(repr(TV3), "3-d toric variety covered by 6 affine patches")

            self.assertFalse(TV3.is_orbifold())
        except ImportError:
            pass

    @skipUnlessModulesPresent("sage.latte")
    def test_004_additional_features_latte(self):
        from sage.all import polytopes
        try:
            P = polytopes.cube()
            self.assertEqual(P.integral_points_count(), 27)
            (1000000000*P).integral_points_count(verbose=True)
        except ImportError:
            pass


if __name__ == "__main__":
    unittest.main()
