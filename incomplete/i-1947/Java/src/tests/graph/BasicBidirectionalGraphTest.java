package tests.graph;

import graph.Utils;
import graph.structures.Graph;
import tests.core.GraphFactory;
import tests.core.Test;

public class BasicBidirectionalGraphTest {
    private Graph graph;

    public BasicBidirectionalGraphTest(GraphFactory factory) {
        startupTest(factory);
    }

    private void startupTest(GraphFactory factory) {
        graph = factory.create(3);
        graph.addVertex(0, 1, 5);
    }

    private void graphMustReturnsDefaultValue() {
        final Integer defaultValue = Utils.DISTANCE_SENTINEL;
        Test.testMessage("Graph must returns a default value: DEFAULT_VALUE=" + defaultValue);
        Test.expectedEquals(graph.getVertexValue(0, 0), defaultValue);
        Test.expectedEquals(graph.getVertexValue(1, 1), defaultValue);
    }

    private void graphMustReturnsTheDistanceBetween2Vertexes() {
        final Integer distance = 5;
        Test.testMessage("Graph must returns the distance between 2 vertexes: expected distance=" + distance);
        Test.expectedEquals(graph.getVertexValue(0, 1), distance);
        Test.expectedEquals(graph.getVertexValue(1, 0), distance);
    }

    public void test() {
        String graphName = Test.getClassName(graph);
        Test.startTestMessage(graphName);
        graphMustReturnsDefaultValue();
        graphMustReturnsTheDistanceBetween2Vertexes();
        Test.endTestMessage(graphName);
    }
}
