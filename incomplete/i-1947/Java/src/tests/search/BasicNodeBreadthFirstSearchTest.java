package tests.search;

import graph.algorithms.search.NodeBreadthFirstSearch;

public class BasicNodeBreadthFirstSearchTest extends BasicNodeSearchTestTemplate {
    public BasicNodeBreadthFirstSearchTest() {
        super(0, 5, (graph) -> new NodeBreadthFirstSearch(graph));
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
        addExpectedNode(null, 0, 0);
        addExpectedNode(0, 1, 1);
        addExpectedNode(0, 2, 1);
        addExpectedNode(0, 3, 1);
        addExpectedNode(2, 4, 2);
    }
}
