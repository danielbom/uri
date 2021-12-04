package tests;

import java.nio.file.Paths;
import java.util.*;

import graph.algorithms.*;
import graph.structures.*;
import problem.*;
import tests.graph.*;
import tests.min_distances.*;
import tests.problem.*;
import tests.core.*;
import tests.search.*;

class PlanTouristTravelFactory1 implements PlanTouristTravelFactory {
    @Override
    public PlanTouristTravel create(MinDistances minDistances, Integer touristsCount) {
        return new PlanTouristTravel1(minDistances);
    }
}

class PlanTouristTravelFactory3 implements PlanTouristTravelFactory {
    @Override
    public PlanTouristTravel create(MinDistances minDistances, Integer touristsCount) {
        return new PlanTouristTravel3(touristsCount, minDistances);
    }
}

public class MainTests {
    static List<GraphFactory> unidirectionalGraphFactories = List.of(
            (n) -> new UnidirectionalGraphSparse() //
    );

    static List<GraphFactory> graphFactories = List.of(
            (n) -> new BidirectionalGraphSparse(),
            (n) -> new BidirectionalGraphMatrix(n),
            (n) -> new BidirectionalGraphMatrix2(n),
            (n) -> new BidirectionalGraphSparse2(n) //
    );
    static List<MinDistancesFactory> minDistancesFactories = List.of(
            (g, n) -> new FloydWarshallMinDistances(n, g), //
            (g, n) -> new DijkstraMinDistances(n, g) //
    );

    static List<PlanTouristTravelFactory> planTouristTravelFactories = List.of(
            new PlanTouristTravelFactory1(), //
            (minDistances, touristsCount) -> new PlanTouristTravel2(touristsCount, minDistances), //
            new PlanTouristTravelFactory3(), //
            (minDistances, touristsCount) -> new PlanTouristTravel4(touristsCount, minDistances) //
    );

    static List<PlanTouristTravelFileTest.Input> filePaths = List.of(
            new PlanTouristTravelFileTest.Input(mkPath("../inputs/03.txt"), 4432) //
    );

    static String mkPath(String filePath) {
        String currentFileDirectory = Paths.get("").toFile().getAbsolutePath();
        return currentFileDirectory + "/" + filePath;
    }

    static void unidirectionalGraphTest(GraphFactory factory) {
        new BasicUnidirectionalGraphTest(factory).test();
        System.gc();
    }

    static void allUnidirectionalGraphTests() {
        unidirectionalGraphFactories.forEach(factory -> unidirectionalGraphTest(factory));
    }

    static void bidirectionalGraphTest(GraphFactory factory) {
        new BasicBidirectionalGraphTest(factory).test();
        System.gc();
    }

    static void allBidirectionalGraphTests() {
        graphFactories.forEach(factory -> bidirectionalGraphTest(factory));
    }

    static void minDistanceTest( //
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory //
    ) {
        new BasicMinDistanceTest1(graphFactory, minDistancesFactory).test();
        System.gc();
        new BasicMinDistanceTest2(graphFactory, minDistancesFactory).test();
        System.gc();
    }

    static void allMinDistanceTests() {
        graphFactories.forEach(graphFactory -> {
            minDistancesFactories.forEach(minDistanceFactory -> {
                minDistanceTest(graphFactory, minDistanceFactory);
            });
        });
    }

    static void nodeDepthFirstSearchTest() {
        new BasicNodeDepthFirstSearchTest().test();
    }

    static void nodeBreadthFirstSearchTest() {
        new BasicNodeBreadthFirstSearchTest().test();
    }

    static void vertexBreadthFirstSearchTest() {
        new BasicVertexBreadthFirstSearchTest().test();
    }

    static void vertexDepthFirstSearchTest() {
        new BasicVertexDepthFirstSearchTest().test();
    }

    static void vertexAStarSearchTest() {
        new BasicVertexAStarSearchTest().test();
    }

    static void planTouristTravelTest(//
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory, //
            PlanTouristTravelFactory planTouristTravelFactory //
    ) {
        new PlanTouristTravelTest1(graphFactory, minDistancesFactory, planTouristTravelFactory).test();
        System.gc();
        new PlanTouristTravelTest2(graphFactory, minDistancesFactory, planTouristTravelFactory).test();
        System.gc();
    }

    static void allPlanTouristTravelTests() {
        planTouristTravelFactories.forEach(planTouristTravelFactory -> {
            graphFactories.forEach(graphFactory -> {
                minDistancesFactories.forEach(minDistancesFactory -> {
                    planTouristTravelTest(graphFactory, minDistancesFactory, planTouristTravelFactory);
                });
            });
        });
    }

    static void planTouristTravelFromFileTest( //
            PlanTouristTravelFileTest.Input input, //
            GraphFactory graphFactory, //
            MinDistancesFactory minDistanceFactory, //
            PlanTouristTravelFactory planTouristTravelFactory //
    ) {
        new PlanTouristTravelFileTest( //
                input, //
                graphFactory, //
                minDistanceFactory, //
                planTouristTravelFactory //
        ).test();
        System.gc();
    }

    static void allPlanTouristTravelFromFileTests() {
        filePaths.forEach(input -> {
            graphFactories.forEach(graphFactory -> {
                minDistancesFactories.forEach(minDistancesFactory -> {
                    planTouristTravelFactories.forEach(planTouristTravelFactory -> {
                        boolean failOnRandomInput = planTouristTravelFactory instanceof PlanTouristTravelFactory1
                                || planTouristTravelFactory instanceof PlanTouristTravelFactory3;

                        if (failOnRandomInput) {
                            // PlanTouristTravel1 not works for random inputs, because they are greedy and
                            // not find the best path to resolve travels
                            return;
                        }

                        planTouristTravelFromFileTest( //
                                input, //
                                graphFactory, //
                                minDistancesFactory, //
                                planTouristTravelFactory //
                        );
                    });
                });
            });
        });
    }

    public static void main(String[] args) {
        Test.initializeTest();

        vertexAStarSearchTest();
        vertexDepthFirstSearchTest();
        vertexBreadthFirstSearchTest();

        nodeDepthFirstSearchTest();
        nodeBreadthFirstSearchTest();

        allUnidirectionalGraphTests();
        allBidirectionalGraphTests();
        allMinDistanceTests();
        allPlanTouristTravelTests();
        allPlanTouristTravelFromFileTests();

        Test.completeTest();
    }
}
