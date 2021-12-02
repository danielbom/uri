import java.util.*;
import java.util.function.BiConsumer;

interface MinDistances {
    public Integer getMinDistance(Integer src, Integer dst);
}

interface GraphAccessor {
    public Integer getVertexValue(Integer src, Integer dst);
}

interface Graph extends GraphAccessor {
    public void addVertex(Integer src, Integer dst, Integer distance);

    public void print();

    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer);
}

class Utils {
    public static List<List<Integer>> makeMatrix(Integer n) {
        List<List<Integer>> matrix = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(n);
            for (int j = 0; j < n; j++) {
                row.add(0);
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
}

class BidirectionalGraphSparse implements Graph {
    private Map<Integer, Map<Integer, Integer>> graph;

    public BidirectionalGraphSparse() {
        graph = new HashMap<Integer, Map<Integer, Integer>>();
    }

    private Map<Integer, Integer> addNodeIfNotExists(Integer node) {
        Map<Integer, Integer> attach = graph.get(node);
        if (attach == null) {
            attach = new HashMap<Integer, Integer>();
            graph.put(node, attach);
        }
        return attach;
    }

    @Override
    public void addVertex(Integer src, Integer dst, Integer distance) {
        addNodeIfNotExists(src).put(dst, distance);
        addNodeIfNotExists(dst).put(src, distance);
    }

    @Override
    public Integer getVertexValue(Integer src, Integer dst) {
        Map<Integer, Integer> attach = graph.get(src);
        if (attach == null) {
            return 0;
        } else {
            Integer distance = attach.get(dst);
            return distance == null ? 0 : distance;
        }
    }

    @Override
    public void print() {
        System.out.println("BidirectionalGraphSparse()");
        graph.forEach((src, attach) -> {
            System.out.print(src + " => ");
            attach.forEach((dst, distance) -> {
                System.out.print("(" + dst + ", " + distance + ")");
            });
            System.out.println();
        });
    }

    @Override
    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer) {
        Map<Integer, Integer> attach = graph.get(node);
        if (attach != null) {
            attach.forEach(consumer);
        }
    }
}

class BidirectionalGraphMatrix2 implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix2(Integer n) {
        graph = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(i + 1);
            for (int j = i + 1; j >= 0; j--) {
                row.add(0);
            }
            graph.add(row);
        }
    }

    public void addVertex(Integer src, Integer dst, Integer distance) {
        if (src >= dst) {
            graph.get(src).set(dst, distance);
        } else {
            addVertex(dst, src, distance);
        }
    }

    public Integer getVertexValue(Integer src, Integer dst) {
        if (src >= dst) {
            return graph.get(src).get(dst);
        } else {
            return getVertexValue(dst, src);
        }
    }

    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer) {
        int n = graph.size();
        for (int i = 0; i < n; i++) {
            Integer distance = getVertexValue(node, i);
            if (distance != 0) {
                consumer.accept(i, distance);
            }
        }
    }

    public void print() {
        System.out.println("BidirecionalGraphMatrix()");
        Utils.printMatrix(graph);
    }
}

class DijkstraMinDistances implements MinDistances {
    class QueueItem implements Comparable<QueueItem> {
        public Integer distance;
        public Integer node;

        public QueueItem(Integer d, Integer n) {
            distance = d;
            node = n;
        }

        public int compareTo(QueueItem other) {
            return distance.compareTo(other.distance);
        }

        @Override
        public String toString() {
            return "QueueItem(node=" + node + ", distance=" + distance + ")";
        }
    }

    class Vertex {
        public Integer src;
        public Integer dst;

        public Vertex(Integer s, Integer d) {
            src = s;
            dst = d;
        }

        @Override
        public String toString() {
            return src + "-" + dst;
        }

        @Override
        public int hashCode() {
            int s = src.hashCode();
            int d = dst.hashCode();
            return (int) (s ^ (s >> 32)) + (d ^ (d >> 32));
        }

        @Override
        public boolean equals(Object other) {
            if (other == this)
                return true;

            if (other instanceof Vertex) {
                Vertex o = (Vertex) other;
                return src == o.src && dst == o.dst;
            } else {
                return false;
            }
        }
    }

    private Map<Vertex, Integer> computed;
    private Graph graph;
    private Integer n;

    public DijkstraMinDistances(Integer nodes, Graph theGraph) {
        computed = new HashMap<Vertex, Integer>();
        graph = theGraph;
        n = nodes;
    }

    public Integer getMinDistance(Integer src, Integer dst) {
        final Vertex vertex = new Vertex(src, dst);
        if (computed.containsKey(vertex)) {
            return computed.get(vertex);
        }

        boolean[] processed = new boolean[n];
        for (int i = 0; i < n; i++) {
            processed[i] = false;
        }

        Queue<QueueItem> queue = new PriorityQueue<QueueItem>();
        queue.add(new QueueItem(0, src));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();

            if (processed[item.node]) {
                continue;
            }

            processed[item.node] = true;
            computed.put(new Vertex(src, item.node), item.distance);

            graph.visitAdjacentNodesOf(item.node, (node, distance) -> {
                queue.add(new QueueItem(distance + item.distance, node));
            });
        }

        return computed.get(vertex);
    }
}

class PlanTouristTravel {
    private static Map<Integer, List<Integer>> tourists;
    private Integer totalDistance;
    private Integer currentPosition;
    private MinDistances minDistances;

    public PlanTouristTravel(MinDistances theMinDistances) {
        tourists = new HashMap<Integer, List<Integer>>();
        totalDistance = 0;
        currentPosition = 0;
        minDistances = theMinDistances;
    }

    public void addTravel(Integer origin, Integer destiny) {
        if (!tourists.containsKey(origin)) {
            tourists.put(origin, new LinkedList<Integer>());
        }

        tourists.get(origin).add(destiny);
    }

    public void computeMinDistance() {
        while (hasTravel()) {
            if (hasTravelFrom(currentPosition)) {
                attendTravel();
            } else {
                findNextTravel();
            }
        }
        goToBegin();
    }

    public Integer getTotalDistance() {
        return totalDistance;
    }

    private void goToBegin() {
        updateDistanceToPosition(0);
    }

    private void attendTravel() {
        List<Integer> travels = tourists.get(currentPosition);
        Integer destiny = travels.remove(0);

        if (travels.isEmpty()) {
            tourists.remove(currentPosition);
        }

        updateDistanceToPosition(destiny);
    }

    private void findNextTravel() {
        Integer minTouristPosition = null;
        Integer minDistance = Integer.MAX_VALUE;
        for (Map.Entry<Integer, List<Integer>> entry : tourists.entrySet()) {
            Integer d = minDistances.getMinDistance(currentPosition, entry.getKey());
            if (d < minDistance) {
                minDistance = d;
                minTouristPosition = entry.getKey();
            }
        }
        if (minTouristPosition != null) {
            updateDistanceToPosition(minTouristPosition, minDistance);
        }
    }

    private boolean hasTravel() {
        return !tourists.isEmpty();
    }

    private boolean hasTravelFrom(Integer position) {
        return tourists.containsKey(position);
    }

    private void updateDistanceToPosition(Integer position) {
        Integer minDistance = minDistances.getMinDistance(currentPosition, position);
        updateDistanceToPosition(position, minDistance);
    }

    private void updateDistanceToPosition(Integer position, Integer minDistance) {
        updateCurrentPosition(position);
        updateDistance(minDistance);
    }

    private void updateDistance(Integer minDistance) {
        totalDistance += minDistance;
    }

    private void updateCurrentPosition(Integer position) {
        currentPosition = position;
    }
}

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
