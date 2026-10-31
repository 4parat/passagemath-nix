"""Run in an environment containing only passagemath-cliquer and its closure.

Using sage.all here would supply dependencies from unrelated distributions and
hide missing runtime dependencies in the extension itself.
"""

import unittest

from sage.graphs.cliquer import clique_number


class GraphInput:
    def __init__(self, vertices, edges):
        self.vertices = vertices
        self.edges = edges

    def order(self):
        return len(self.vertices)

    def __iter__(self):
        return iter(self.vertices)

    def edge_iterator(self, labels=None):
        return iter(self.edges)


class CliquerTests(unittest.TestCase):
    def test_triangle(self):
        graph = GraphInput([0, 1, 2], [(0, 1), (1, 2), (0, 2)])
        self.assertEqual(clique_number(graph), 3)

    def test_empty_graph(self):
        self.assertEqual(clique_number(GraphInput([], [])), 0)


if __name__ == "__main__":
    unittest.main()
