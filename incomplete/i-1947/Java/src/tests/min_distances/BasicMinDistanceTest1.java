package tests.min_distances;

import tests.core.*;

public class BasicMinDistanceTest1 extends MinDistancesTestTemplate {
    private final int nodesCount = 3;

    public BasicMinDistanceTest1(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        super(graphFactory, minDistancesFactory);
    }

    @Override
    protected int getNodesCount() {
        return nodesCount;
    }

    protected void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        graph = graphFactory.create(nodesCount);
        graph.addVertex(0, 1, 2);
        graph.addVertex(1, 2, 4);
        graph.addVertex(2, 0, 3);
        minDistances = minDistancesFactory.create(graph, nodesCount);
    }

    protected void minDistancesMustReturnsCorrectMinimumDistances() {
        Test.testMessage("MinDistance must returns the correct minimum distances of each vertex");
        minDistanceBetweenVertexMustBe(0, 1, 2);
        minDistanceBetweenVertexMustBe(1, 2, 4);
        minDistanceBetweenVertexMustBe(2, 0, 3);
    }
}
