package tests.basics.min_distances;

import tests.core.*;

public class BasicMinDistanceTest2 extends MinDistancesTestTemplate {
    private final int nodesCount = 5;

    public BasicMinDistanceTest2(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        super(graphFactory, minDistancesFactory);
    }

    @Override
    protected int getNodesCount() {
        return nodesCount;
    }

    @Override
    protected void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        graph = graphFactory.create(nodesCount);
        graph.addVertex(0, 1, 3);
        graph.addVertex(0, 2, 7);
        graph.addVertex(0, 3, 5);
        graph.addVertex(1, 2, 2);
        graph.addVertex(2, 3, 6);
        graph.addVertex(2, 4, 5);
        graph.addVertex(3, 4, 3);
        minDistances = minDistancesFactory.create(graph, nodesCount);
    }

    @Override
    protected void minDistancesMustReturnsCorrectMinimumDistances() {
        Test.testMessage("MinDistance must returns the correct minimum distances of each vertex");
        minDistanceBetweenVertexMustBe(0, 1, 3);
        minDistanceBetweenVertexMustBe(0, 2, 5);
        minDistanceBetweenVertexMustBe(0, 3, 5);
        minDistanceBetweenVertexMustBe(0, 4, 8);

        minDistanceBetweenVertexMustBe(1, 2, 2);
        minDistanceBetweenVertexMustBe(1, 3, 8);
        minDistanceBetweenVertexMustBe(1, 4, 7);

        minDistanceBetweenVertexMustBe(2, 3, 6);
        minDistanceBetweenVertexMustBe(2, 4, 5);
    }
}
