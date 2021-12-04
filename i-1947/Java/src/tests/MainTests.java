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

class PlanTouristTravelFactory1 implements PlanTouristTravelFactory {
    @Override
    public PlanTouristTravel create(MinDistances minDistances, Integer touristsCount) {
        return new PlanTouristTravel1(minDistances);
    }
}

public class MainTests {
    static String mkPath(String filePath) {
        String currentFileDirectory = Paths.get("").toFile().getAbsolutePath();
        return currentFileDirectory + "/" + filePath;
    }

    static void bidirectionalGraphTest(GraphFactory factory) {
        new BasicGraphTest(factory).test();
        System.gc();
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
                new PlanTouristTravelFactory1(), //
                (minDistances, touristsCount) -> new PlanTouristTravel2(touristsCount, minDistances) //
        );

        List<PlanTouristTravelFileTest.Input> filePaths = List.of(
                new PlanTouristTravelFileTest.Input(mkPath("../inputs/03.txt"), 4432) //
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
            planTouristTravelFactories.forEach(planTouristTravelFactory -> {
                if (planTouristTravelFactory instanceof PlanTouristTravelFactory1) {
                    // PlanTouristTravel1 not works for random inputs, because they are greedy and
                    // not find the best path to resolve travels
                    return;
                }

                graphFactories.forEach(graphFactory -> {
                    minDistancesFactories.forEach(minDistancesFactory -> {
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

        Test.completeTest();
    }
}
