package tests;

import java.nio.file.Paths;
import java.util.*;

import graph.algorithms.*;
import graph.structures.*;
import problem.*;
import tests.basics.graph.*;
import tests.basics.min_distances.*;
import tests.basics.problem.*;
import tests.core.*;

public class GraphTests {
    static String mkPath(String filePath) {
        String currentFileDirectory = Paths.get("").toFile().getAbsolutePath();
        return currentFileDirectory + "/" + filePath;
    }

    static void bidirectionalGraphTest(GraphFactory factory) {
        new BasicGraphTest(factory).test();
    }

    static void minDistanceTest( //
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory //
    ) {
        new BasicMinDistanceTest1(graphFactory, minDistancesFactory).test();
        new BasicMinDistanceTest2(graphFactory, minDistancesFactory).test();
    }

    static void planTouristTravelTest(//
            GraphFactory graphFactory, //
            MinDistancesFactory minDistancesFactory, //
            PlanTouristTravelFactory planTouristTravelFactory //
    ) {
        new PlanTouristTravelTest1(graphFactory, minDistancesFactory, planTouristTravelFactory).test();
        new PlanTouristTravelTest2(graphFactory, minDistancesFactory, planTouristTravelFactory).test();
    }

    static void planTouristTravelFromFileTest(PlanTouristTravelFileTest.Input input) {
        new PlanTouristTravelFileTest( //
                input, //
                (n) -> new BidirectionalGraphSparse2(n), //
                (g, n) -> new DijkstraMinDistances(n, g), //
                (minDistances, touristsCount) -> new PlanTouristTravel2(touristsCount, minDistances) //
        ).test();
    }

    public static void main(String[] args) {
        Test.initializeTest();

        List<GraphFactory> graphFactories = List.of(
                (n) -> new BidirectionalGraphSparse(),
                (n) -> new BidirectionalGraphMatrix(n),
                (n) -> new BidirectionalGraphMatrix2(n),
                (n) -> new BidirectionalGraphSparse2(n) //
        );
        List<MinDistancesFactory> minDistancesFactories = List.of(
                (g, n) -> new FloydWarshallMinDistances(n, g), //
                (g, n) -> new DijkstraMinDistances(n, g) //
        );

        List<PlanTouristTravelFactory> planTouristTravelFactories = List.of(
                (minDistances, touristsCount) -> new PlanTouristTravel1(minDistances), //
                (minDistances, touristsCount) -> new PlanTouristTravel2(touristsCount, minDistances) //
        );

        List<PlanTouristTravelFileTest.Input> filePaths = List.of(
                new PlanTouristTravelFileTest.Input(mkPath("../inputs/01.txt"), 9), //
                new PlanTouristTravelFileTest.Input(mkPath("../inputs/02.txt"), 26) //
        );

        graphFactories.forEach(factory -> bidirectionalGraphTest(factory));

        graphFactories.forEach(graphFactory -> {
            minDistancesFactories.forEach(minDistanceFactory -> {
                minDistanceTest(graphFactory, minDistanceFactory);
            });
        });

        planTouristTravelFactories.forEach(planTouristTravelFactory -> {
            graphFactories.forEach(graphFactory -> {
                minDistancesFactories.forEach(minDistancesFactory -> {
                    planTouristTravelTest(graphFactory, minDistancesFactory, planTouristTravelFactory);
                });
            });
        });

        filePaths.forEach(input -> {
            planTouristTravelFromFileTest(input);
        });

        Test.completeTest();
    }
}
