import unittest

from sage.all import GF, Graph, PolynomialRing, QQ, ZZ, factor, matrix


class SageFeatureTests(unittest.TestCase):
    def test_exact_integer_factorization(self):
        n = ZZ(2) ** 10 * ZZ(3) ** 3
        self.assertEqual(list(factor(n)), [(ZZ(2), 10), (ZZ(3), 3)])

    def test_rational_arithmetic_is_exact(self):
        value = QQ(1) / 3 + QQ(1) / 6
        self.assertEqual(value, QQ(1) / 2)
        self.assertIs(value.parent(), QQ)

    def test_polynomial_factorization(self):
        ring = PolynomialRing(QQ, "t")
        t = ring.gen()
        polynomial = t**4 - 1
        factors = factor(polynomial)
        reconstructed = ring.one()
        for factor_polynomial, multiplicity in factors:
            reconstructed *= factor_polynomial**multiplicity
        self.assertEqual(reconstructed, polynomial)

    def test_matrix_determinant_over_rationals(self):
        A = matrix(QQ, [[1, 2], [3, 4]])
        self.assertEqual(A.det(), -2)
        self.assertEqual(A * A.inverse(), matrix.identity(QQ, 2))

    def test_finite_field_arithmetic(self):
        field = GF(7)
        self.assertEqual(field(3) ** 6, field.one())
        self.assertEqual(field(3) + field(5), field(1))

    def test_graph_algorithms(self):
        triangle = Graph([(0, 1), (1, 2), (2, 0)])
        self.assertEqual(triangle.chromatic_number(), 3)
        self.assertEqual(triangle.size(), 3)


if __name__ == "__main__":
    unittest.main()
