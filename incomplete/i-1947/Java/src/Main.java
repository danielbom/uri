import java.util.*;

import graph.algorithms.*;
import graph.structures.*;
import problem.*;

public class Main {
    private static Scanner scan = new Scanner(System.in);
    private static Integer streetLimit;
    private static Integer streetsCount;
    private static Integer touristsCount;
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
        streetsCount = firstLine.get(1);
        touristsCount = firstLine.get(2);
    }

    private static void buildGraph() {
        streetGraph = new BidirectionalGraphSparse2(streetLimit);

        for (int i = 0; i < streetsCount; i++) {
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
        planTouristTravel = new PlanTouristTravel4(touristsCount, minDistances);
        for (int i = 0; i < touristsCount; i++) {
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
