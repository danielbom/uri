package tests.search;

import graph.algorithms.search.*;
import graph.structures.BidirectionalGraphMatrix2;

public class BasicVertexDepthFirstSearchTest extends BasicVertexSearchTestTemplate {
    public BasicVertexDepthFirstSearchTest() {
        super(0, 5, (graph) -> new VertexDepthFirstSearch(graph), (n) -> new BidirectionalGraphMatrix2(n));
    }

    @Override
    protected void createGraph() {
        addVertex(0, 1, 3);
        addVertex(0, 2, 7);
        addVertex(0, 3, 5);
        addVertex(1, 2, 2);
        addVertex(2, 3, 6);
        addVertex(2, 4, 5);
        addVertex(3, 4, 3);
    }

    @Override
    protected void createExpectedResult() {
        addExpectedVertex(0, 3, 5, 0);
        addExpectedVertex(3, 4, 3, 1);
        addExpectedVertex(4, 3, 3, 2);
        addExpectedVertex(4, 2, 5, 2);
        addExpectedVertex(2, 4, 5, 3);
        addExpectedVertex(2, 3, 6, 3);
        addExpectedVertex(2, 1, 2, 3);
        addExpectedVertex(1, 2, 2, 4);
        addExpectedVertex(1, 0, 3, 4);
        addExpectedVertex(2, 0, 7, 3);
        addExpectedVertex(3, 2, 6, 1);
        addExpectedVertex(3, 0, 5, 1);
        addExpectedVertex(0, 2, 7, 0);
        addExpectedVertex(0, 1, 3, 0);
    }
}
