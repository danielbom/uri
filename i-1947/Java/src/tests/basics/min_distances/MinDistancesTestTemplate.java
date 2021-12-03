package tests.basics.min_distances;

import graph.*;
import graph.algorithms.*;
import tests.core.*;

public abstract class MinDistancesTestTemplate {
    protected Graph graph;
    protected MinDistances minDistances;

    public MinDistancesTestTemplate(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        startupTest(graphFactory, minDistancesFactory);
    }

    protected abstract int getNodesCount();

    protected abstract void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory);

    protected abstract void minDistancesMustReturnsCorrectMinimumDistances();

    private void nodesMustHave0DistanceFromSelf() {
        Test.testMessage("MinDistance must return 0 from each node to itself");
        for (int i = 0; i < getNodesCount(); i++) {
            Test.expectedEquals(minDistances.getMinDistance(i, i), 0);
        }
    }

    protected void minDistanceBetweenVertexMustBe(Integer source, Integer destiny, Integer distance) {
        Test.expectedEquals(minDistances.getMinDistance(source, destiny), distance);
        Test.expectedEquals(minDistances.getMinDistance(destiny, source), distance);
    }

    public void test() {
        String minDistanceName = Test.getClassName(minDistances);
        Test.startTestMessage(minDistanceName);
        minDistancesMustReturnsCorrectMinimumDistances();
        nodesMustHave0DistanceFromSelf();
        Test.endTestMessage(minDistanceName);
    }
}
