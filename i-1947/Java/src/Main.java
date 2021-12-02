import java.util.*;

import graph.*;
import graph.algorithms.*;

public class Main {
    private static Scanner scan = new Scanner(System.in);
    private static Integer n;
    private static Integer m;
    private static Integer t;
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
        n = firstLine.get(0);
        m = firstLine.get(1);
        t = firstLine.get(2);
    }

    private static void buildGraph() {
        if (m * 10 < n) {
            streetGraph = new BidirectionalGraphSparse();
        } else {
            streetGraph = new BidirectionalGraphMatrix2(n);
        }

        for (int i = 0; i < m; i++) {
            List<Integer> streetLine = readInts();

            Integer a = streetLine.get(0) - 1;
            Integer b = streetLine.get(1) - 1;
            Integer c = streetLine.get(2);

            streetGraph.addVertex(a, b, c);
        }

        // minDistances = new FloydWarshallMinDistances(n, streetGraph);
        minDistances = new DijkstraMinDistances(n, streetGraph);
    }

    private static void saveTouristsTravel() {
        planTouristTravel = new PlanTouristTravel(minDistances);
        for (int i = 0; i < t; i++) {
            List<Integer> touristLine = readInts();
            Integer o = touristLine.get(0) - 1;
            Integer d = touristLine.get(1) - 1;
            planTouristTravel.addTravel(o, d);
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
