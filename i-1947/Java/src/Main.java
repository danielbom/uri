import java.util.*;

import graph.*;
import graph.algorithms.*;
import problem.PlanTouristTravel;

public class Main {
    private static Scanner scan = new Scanner(System.in);
    private static Integer streetLimit;
    private static Integer numberOfStreets;
    private static Integer numberOfTourists;
    private static Graph streetGraph;
    private static MinDistances minDistances;
    private static PlanTouristTravel planTouristTravel;

    private static List<Integer> readInts() {
        String line = scan.nextLine();
        ArrayList<Integer> result = new ArrayList<Integer>(3);
        for (String item : line.split(" ")) {
            result.add(Integer.parseInt(item));
        }
        return result;
    }

    private static void readSpecification() {
        List<Integer> firstLine = readInts();
        streetLimit = firstLine.get(0);
        numberOfStreets = firstLine.get(1);
        numberOfTourists = firstLine.get(2);
    }

    private static void buildGraph() {
        if (numberOfStreets * 10 < streetLimit) {
            streetGraph = new BidirectionalGraphSparse();
        } else {
            streetGraph = new BidirectionalGraphMatrix2(streetLimit);
        }

        for (int i = 0; i < numberOfStreets; i++) {
            List<Integer> streetLine = readInts();

            Integer origin = streetLine.get(0) - 1;
            Integer destiny = streetLine.get(1) - 1;
            Integer distance = streetLine.get(2);

            streetGraph.addVertex(origin, destiny, distance);
        }

        // minDistances = new FloydWarshallMinDistances(streetLimit, streetGraph);
        minDistances = new DijkstraMinDistances(streetLimit, streetGraph);
    }

    private static void saveTouristsTravel() {
        planTouristTravel = new PlanTouristTravel(minDistances);
        for (int i = 0; i < numberOfTourists; i++) {
            List<Integer> touristLine = readInts();
            Integer origin = touristLine.get(0) - 1;
            Integer destiny = touristLine.get(1) - 1;
            planTouristTravel.addTravel(origin, destiny);
        }
    }

    private static void computeDistance() {
        planTouristTravel.computeMinDistance();
    }

    private static void showTotalDistance() {
        System.out.println(planTouristTravel.getTotalDistance());
    }

    public static void main(String[] args) {
        readSpecification();
        buildGraph();
        saveTouristsTravel();
        computeDistance();
        showTotalDistance();
    }
}
