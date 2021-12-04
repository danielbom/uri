package tests.search;

import graph.algorithms.search.*;
import graph.structures.*;

public class BasicVertexAStarSearchTest extends BasicVertexSearchTestTemplate {
    public BasicVertexAStarSearchTest() {
        super(0, 5, (graph) -> new VertexAStarSearch(graph), (n) -> new UnidirectionalGraphSparse());
    }

    @Override
    protected void createGraph() {
        addVertex(0, 1, 2);
        addVertex(1, 2, 4);
        addVertex(2, 0, 3);

        addVertex(1, 0, 2);
        addVertex(0, 2, 6);
    }

    @Override
    protected void createExpectedResult() {
        addExpectedVertex(0, 1, 2, 0);
        addExpectedVertex(1, 0, 4, 1);
        addExpectedVertex(1, 2, 6, 1);
        addExpectedVertex(2, 0, 9, 2);
        addExpectedVertex(0, 2, 6, 0);
        addExpectedVertex(2, 0, 9, 1);
    }
}
