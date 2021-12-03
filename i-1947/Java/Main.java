import java.util.*;
import java.util.function.BiConsumer;

/**
 * Based on
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */

interface GraphAccessor {
    public int getVertexValue(int source, int destiny);

    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer);
}

interface Graph extends GraphAccessor {
    public void addVertex(int source, int destiny, int distance);

    public void print();
}

interface MinDistances {
    public int getMinDistance(int source, int destiny);
}

interface PlanTouristTravel {
    public void addTravel(int origin, int destiny);

    public void computeMinDistance();

    public int getTotalDistance();
}

class Utils {
    public static final int DISTANCE_SENTINEL = -1;

    public static List<List<Integer>> makeMatrix(Integer n) {
        List<List<Integer>> matrix = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(n);
            for (int j = 0; j < n; j++) {
                row.add(DISTANCE_SENTINEL);
            }
            matrix.add(row);
        }
        return matrix;
    }

    public static void printMatrix(List<List<Integer>> matrix) {
        matrix.forEach(row -> {
            System.out.print("[");
            int i = 0;
            for (Integer x : row) {
                if (i > 0)
                    System.out.print(",");
                System.out.print(x);
                i += 1;
            }
            System.out.println("]");
        });
    }

    public static boolean isSentinel(Integer distance) {
        return distance == DISTANCE_SENTINEL;
    }
}

class BidirectionalGraphSparse2 implements Graph {
    private class Vertex {
        public Integer node;
        public Integer distance;

        public Vertex(Integer theNode, Integer theDistance) {
            node = theNode;
            distance = theDistance;
        }
    }

    public static final Integer MAX_NODES = (int) 1e4 + 10;

    private List<List<Vertex>> graph;

    public BidirectionalGraphSparse2(Integer size) {
        createGraph(size);
    }

    private void createGraph(Integer size) {
        graph = new ArrayList<List<Vertex>>(size);
        for (int i = 0; i < size; i++) {
            graph.add(new ArrayList<>());
        }
    }

    @Override
    public void addVertex(int source, int destiny, int distance) {
        graph.get(source).add(new Vertex(destiny, distance));
        graph.get(destiny).add(new Vertex(source, distance));
    }

    @Override
    public int getVertexValue(int source, int destiny) {
        for (Vertex vertex : graph.get(source)) {
            if (vertex.node == destiny) {
                return vertex.distance;
            }
        }
        return Utils.DISTANCE_SENTINEL;
    }

    @Override
    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer) {
        for (Vertex vertex : graph.get(node)) {
            consumer.accept(vertex.node, vertex.distance);
        }
    }

    @Override
    public void print() {
        System.out.println("BidirectionalGraphSparse2()");
        int n = graph.size();
        for (int i = 0; i < n; i++) {
            if (!graph.get(i).isEmpty()) {
                System.out.print(i + " => ");
                for (Vertex vertex : graph.get(i)) {
                    System.out.print("(" + vertex.node + ", " + vertex.distance + ")");
                }
                System.out.println();
            }
        }
    }
}

class DijkstraMinDistances implements MinDistances {
    private class QueueItem implements Comparable<QueueItem> {
        public int distance;
        public int id;

        public QueueItem(int theId, int theDistance) {
            id = theId;
            distance = theDistance;
        }

        public int compareTo(QueueItem other) {
            return Integer.compare(distance, other.distance);
        }
    }

    private class Vertex {
        public int source;
        public int destiny;

        public Vertex(int s, int d) {
            source = s;
            destiny = d;
        }

        @Override
        public String toString() {
            return source + "-" + destiny;
        }

        @Override
        public int hashCode() {
            int s = source;
            int d = destiny;
            return (int) (s ^ (s >> 32)) + (d ^ (d >> 32));
        }

        @Override
        public boolean equals(Object other) {
            if (other == this)
                return true;

            if (other instanceof Vertex) {
                Vertex o = (Vertex) other;
                return source == o.source && destiny == o.destiny;
            } else {
                return false;
            }
        }
    }

    private Map<Vertex, Integer> computed;
    private Graph graph;
    private Integer nodesCount;

    public DijkstraMinDistances(Integer theNodesCount, Graph theGraph) {
        computed = new HashMap<Vertex, Integer>();
        graph = theGraph;
        nodesCount = theNodesCount;
    }

    public int getMinDistance(int source, int destiny) {
        final Vertex vertex = new Vertex(source, destiny);
        if (computed.containsKey(vertex)) {
            return computed.get(vertex);
        }

        boolean[] processed = new boolean[nodesCount];
        for (int i = 0; i < nodesCount; i++) {
            processed[i] = false;
        }

        Queue<QueueItem> queue = new PriorityQueue<QueueItem>();
        queue.add(new QueueItem(source, 0));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();

            if (processed[item.id]) {
                continue;
            }

            processed[item.id] = true;
            computed.put(new Vertex(source, item.id), item.distance);

            graph.visitAdjacentNodesOf(item.id, (node, distance) -> {
                queue.add(new QueueItem(node, distance + item.distance));
            });
        }

        return computed.get(vertex);
    }
}

class PlanTouristTravel2 implements PlanTouristTravel {
    private class Travel {
        public int source;
        public int destiny;

        Travel(int theSource, int theDestiny) {
            source = theSource;
            destiny = theDestiny;
        }
    }

    public static final int MAX_COSTS = 17;
    public static final int MAX_BEST_COSTS = (1 << 16) + 100; // + 65k

    private List<Travel> travels;
    private MinDistances minDistances;
    private int touristsCountIncremented;
    private int possibilities;
    private int totalDistance;

    private int[][] costs;
    private int[][] bestCosts;

    public PlanTouristTravel2(int touristsCount, MinDistances theMinDistances) {
        touristsCountIncremented = touristsCount + 1;
        possibilities = 1 << touristsCountIncremented;

        minDistances = theMinDistances;
        totalDistance = 0;
        costs = new int[MAX_COSTS][MAX_COSTS];
        bestCosts = new int[MAX_COSTS][MAX_BEST_COSTS];
        travels = new ArrayList<Travel>(touristsCountIncremented);
        travels.add(new Travel(0, 0));
    }

    public void addTravel(int source, int destiny) {
        travels.add(new Travel(source, destiny));
        int distance = minDistances.getMinDistance(source, destiny);
        updateDistance(distance);
    }

    public void computeMinDistance() {
        int initialPosition = 0;
        int initialBitmask = 1;
        // The initial bitmask are 1 to be used as a binary mapper
        // 0001, 0010, 0011, ...
        computeBaseCosts();
        initializeBestCosts();
        updateDistance(recursiveSolveBestCost(initialPosition, initialBitmask));
    }

    public int getTotalDistance() {
        return totalDistance;
    }

    private void computeBaseCosts() {
        for (int i = 0; i < touristsCountIncremented; i++) {
            for (int j = 0; j < touristsCountIncremented; j++) {
                int source = travels.get(i).destiny;
                int destiny = travels.get(j).source;
                int distance = minDistances.getMinDistance(source, destiny);
                costs[i][j] = distance;
            }
        }
    }

    private void initializeBestCosts() {
        for (int i = 0; i < touristsCountIncremented; i++) {
            for (int j = 0; j < possibilities; j++) {
                bestCosts[i][j] = -1;
            }
        }
    }

    private int recursiveSolveBestCost(int position, int bitmask) {
        if (isBestCostInitialized(position, bitmask)) {
            return bestCosts[position][bitmask];
        }

        if (bitmask == possibilities - 1) {
            int bestCost = costs[position][0];
            bestCosts[position][bitmask] = bestCost;
            return bestCost;
        }

        int best = (int) 1e8;
        for (int nextTourist = 0; nextTourist < touristsCountIncremented; nextTourist++) {
            int nextTouristBit = 1 << nextTourist;
            if (position != nextTourist && theNextTouristIsNotMarked(bitmask, nextTouristBit)) {
                int bitmaskMarkedTourist = bitmask | nextTouristBit;
                int nextTouristBestCost = recursiveSolveBestCost(nextTourist, bitmaskMarkedTourist);
                int nextBestCost = costs[position][nextTourist] + nextTouristBestCost;
                best = Math.min(best, nextBestCost);
            }
        }

        bestCosts[position][bitmask] = best;
        return best;
    }

    private boolean theNextTouristIsNotMarked(int bitmask, int nextTouristBit) {
        return (bitmask & nextTouristBit) == 0;
    }

    private boolean isBestCostInitialized(int position, int bitmask) {
        return bestCosts[position][bitmask] != -1;
    }

    private void updateDistance(int distance) {
        totalDistance += distance;
    }
}

public class Main {
    private static Scanner scan = new Scanner(System.in);
    private static int streetLimit;
    private static int streetsCount;
    private static int touristsCount;
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

            int origin = streetLine.get(0) - 1;
            int destiny = streetLine.get(1) - 1;
            int distance = streetLine.get(2);

            streetGraph.addVertex(origin, destiny, distance);
        }

        // minDistances = new FloydWarshallMinDistances(streetLimit, streetGraph);
        minDistances = new DijkstraMinDistances(streetLimit, streetGraph);
    }

    private static void saveTouristsTravel() {
        planTouristTravel = new PlanTouristTravel2(touristsCount, minDistances);
        for (int i = 0; i < touristsCount; i++) {
            List<Integer> touristLine = readInts();
            int origin = touristLine.get(0) - 1;
            int destiny = touristLine.get(1) - 1;
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
