package tests.graph;

import graph.Utils;
import graph.structures.Graph;
import tests.core.*;

public class BasicUnidirectionalGraphTest {
    private Graph graph;
    private final Integer distance = 5;

    public BasicUnidirectionalGraphTest(GraphFactory factory) {
        startupTest(factory);
    }

    private void startupTest(GraphFactory factory) {
        graph = factory.create(3);
        graph.addVertex(0, 1, distance);
    }

    private void graphMustReturnsTheDistanceBetween2UnidirecionalVertexes() {
        Test.testMessage("Graph must returns the distance between 2 vertexes: expected forward distance=" + distance);
        Test.expectedEquals(graph.getVertexValue(0, 1), distance);
        Test.expectedEquals(graph.getVertexValue(1, 0), Utils.DISTANCE_SENTINEL);
    }

    public void test() {
        String graphName = Test.getClassName(graph);
        Test.startTestMessage(graphName);
        graphMustReturnsTheDistanceBetween2UnidirecionalVertexes();
        Test.endTestMessage(graphName);
    }
}
