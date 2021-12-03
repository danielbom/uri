package tests;

import java.util.*;

import graph.*;
import graph.algorithms.*;
import problem.PlanTouristTravel;

class Test {
    static void expectedEquals(Object expected, Object result) {
        boolean isReferenceEquals = expected == result;
        boolean isValueEquals = expected != null && result != null && expected.equals(result);
        boolean isEquals = isReferenceEquals || isValueEquals;
        if (!isEquals) {
            new RuntimeException("Expectation equals fail: '" + expected + "' to be '" + result + "'");
        }
    }

    static void testMessage(String message) {
        System.out.println("🚩\t" + message);
    }

    static void startTestMessage(String message) {
        System.out.println("🚩 Start test: " + message);
    }

    static void endTestMessage(String message) {
        System.out.println("✅ End test: " + message + "\n");
    }

    static void completeTest() {
        System.out.println("🥳 Tests completed!");
    }

    static void initializeTest() {
        System.out.println("🏁 Tests started");
    }
}

interface GraphFactory {
    public Graph create(Integer n);
}

interface MinDistancesFactory {
    public MinDistances create(Graph graph, Integer n);
}

class BasicGraphTest {
    private Graph graph;

    public BasicGraphTest(GraphFactory factory) {
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
        String graphName = graph.getClass().getName();
        Test.startTestMessage(graphName);
        graphMustReturnsDefaultValue();
        graphMustReturnsTheDistanceBetween2Vertexes();
        Test.endTestMessage(graphName);
    }
}

abstract class MinDistancesTestTemplate {
    protected Graph graph;
    protected MinDistances minDistances;

    public MinDistancesTestTemplate(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        startupTest(graphFactory, minDistancesFactory);
    }

    protected abstract void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory);

    protected abstract void minDistancesMustReturnsCorrectMinimumDistances();

    public void test() {
        String minDistanceName = minDistances.getClass().getName();
        Test.startTestMessage(minDistanceName);
        minDistancesMustReturnsCorrectMinimumDistances();
        Test.endTestMessage(minDistanceName);
    }
}

class BasicMinDistanceTest extends MinDistancesTestTemplate {
    public BasicMinDistanceTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        super(graphFactory, minDistancesFactory);
    }

    protected void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        Integer nodesCount = 3;
        graph = graphFactory.create(nodesCount);
        graph.addVertex(0, 1, 2);
        graph.addVertex(1, 2, 4);
        graph.addVertex(2, 0, 3);
        minDistances = minDistancesFactory.create(graph, nodesCount);
    }

    protected void minDistancesMustReturnsCorrectMinimumDistances() {
        Test.testMessage("MinDistance must returns the correct minimum distances of each vertex");
        Test.expectedEquals(minDistances.getMinDistance(0, 1), 2);
        Test.expectedEquals(minDistances.getMinDistance(1, 0), 2);
        Test.expectedEquals(minDistances.getMinDistance(1, 2), 4);
        Test.expectedEquals(minDistances.getMinDistance(2, 1), 4);
        Test.expectedEquals(minDistances.getMinDistance(2, 0), 3);
        Test.expectedEquals(minDistances.getMinDistance(0, 2), 3);
        Test.expectedEquals(minDistances.getMinDistance(0, 0), 0);
        Test.expectedEquals(minDistances.getMinDistance(1, 1), 0);
        Test.expectedEquals(minDistances.getMinDistance(2, 2), 0);
    }
}

class BasicMinDistanceTest2 extends MinDistancesTestTemplate {
    public BasicMinDistanceTest2(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        super(graphFactory, minDistancesFactory);
    }

    protected void startupTest(GraphFactory graphFactory, MinDistancesFactory minDistancesFactory) {
        Integer nodesCount = 5;
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

    private void minDistanceBetweenVertexMustBe(Integer src, Integer dst, Integer distance) {
        Test.expectedEquals(minDistances.getMinDistance(src, dst), distance);
        Test.expectedEquals(minDistances.getMinDistance(dst, src), distance);
    }

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

abstract class PlanTouristTravelTestCaseTemplate {
    protected GraphFactory graphFactory;
    protected MinDistancesFactory minDistancesFactory;

    protected Graph graph;
    protected MinDistances minDistances;
    protected PlanTouristTravel planTouristTravel;

    protected Integer n;
    private Integer expectedResult;

    public PlanTouristTravelTestCaseTemplate( //
            Integer nodesCount, //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory, //
            Integer theExpectedResult //
    ) {
        n = nodesCount;
        graphFactory = theGraphFactory;
        minDistancesFactory = theMinDistancesFactory;
        expectedResult = theExpectedResult;
    }

    protected abstract void buildGraph();

    protected abstract void saveTouristsTravel();

    private void computeDistance() {
        planTouristTravel.computeMinDistance();
    }

    private void checkDistance() {
        Integer result = planTouristTravel.getTotalDistance();
        Test.testMessage("Total distance must be: " + expectedResult);
        Test.expectedEquals(expectedResult, result);
    }

    public void test() {
        graph = graphFactory.create(n);
        buildGraph();

        minDistances = minDistancesFactory.create(graph, n);
        planTouristTravel = new PlanTouristTravel(minDistances);
        saveTouristsTravel();

        String planTouristTravelName = this.getClass().getName();
        String graphName = graph.getClass().getName();
        String minDistancesName = minDistances.getClass().getName();
        String message = planTouristTravelName + " w/ " + graphName + " + " + minDistancesName;

        Test.startTestMessage(message);
        computeDistance();
        checkDistance();
        Test.endTestMessage(message);
    }
}

class PlanTouristTravelTestCase1 extends PlanTouristTravelTestCaseTemplate {
    public PlanTouristTravelTestCase1( //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory //
    ) {
        super(3, theGraphFactory, theMinDistancesFactory, 9);
    }

    @Override
    protected void buildGraph() {
        graph.addVertex(0, 1, 2);
        graph.addVertex(1, 2, 4);
        graph.addVertex(2, 0, 3);
    }

    @Override
    protected void saveTouristsTravel() {
        planTouristTravel.addTravel(1, 2);
    }
}

class PlanTouristTravelTestCase2 extends PlanTouristTravelTestCaseTemplate {
    public PlanTouristTravelTestCase2( //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory //
    ) {
        super(5, theGraphFactory, theMinDistancesFactory, 26);
    }

    @Override
    protected void buildGraph() {
        graph.addVertex(0, 1, 3);
        graph.addVertex(0, 2, 7);
        graph.addVertex(0, 3, 5);
        graph.addVertex(1, 2, 2);
        graph.addVertex(2, 3, 6);
        graph.addVertex(2, 4, 5);
        graph.addVertex(3, 4, 3);
    }

    @Override
    protected void saveTouristsTravel() {
        planTouristTravel.addTravel(1, 3);
        planTouristTravel.addTravel(3, 4);
        planTouristTravel.addTravel(0, 2);
    }
}

public class GraphTests {
    static void bidirectionalGraphTest(GraphFactory factory) {
        new BasicGraphTest(factory).test();
    }

    static void minDistanceTest( //
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory //
    ) {
        new BasicMinDistanceTest(graphFactory, minDistancesFactory).test();
        new BasicMinDistanceTest2(graphFactory, minDistancesFactory).test();
    }

    static void planTouristTravelTest(//
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory //
    ) {
        new PlanTouristTravelTestCase1(graphFactory, minDistancesFactory).test();
        new PlanTouristTravelTestCase2(graphFactory, minDistancesFactory).test();
    }

    public static void main(String[] args) {
        Test.initializeTest();

        List<GraphFactory> graphFactories = List.of(
                (n) -> new BidirectionalGraphSparse(),
                (n) -> new BidirectionalGraphMatrix(n),
                (n) -> new BidirectionalGraphMatrix2(n) //
        );
        List<MinDistancesFactory> minDistancesFactories = List.of(
                (g, n) -> new FloydWarshallMinDistances(n, g), //
                (g, n) -> new DijkstraMinDistances(n, g) //
        );

        graphFactories.forEach(factory -> bidirectionalGraphTest(factory));

        graphFactories.forEach(graphFactory -> {
            minDistancesFactories.forEach(minDistanceFactory -> {
                minDistanceTest(graphFactory, minDistanceFactory);
            });
        });

        graphFactories.forEach(graphFactory -> {
            minDistancesFactories.forEach(minDistanceFactory -> {
                planTouristTravelTest(graphFactory, minDistanceFactory);
            });
        });

        Test.completeTest();
    }
}
