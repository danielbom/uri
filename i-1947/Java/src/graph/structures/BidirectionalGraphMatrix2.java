package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Graph;
import graph.Utils;

public class BidirectionalGraphMatrix2 implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix2(Integer n) {
        createTriangleMatrixGraph(n);
    }

    private void createTriangleMatrixGraph(Integer n) {
        graph = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(i + 1);
            for (int j = i + 1; j >= 0; j--) {
                row.add(Utils.DISTANCE_SENTINEL);
            }
            graph.add(row);
        }
    }

    public void addVertex(int source, int destiny, int distance) {
        if (source >= destiny) {
            graph.get(source).set(destiny, distance);
        } else {
            addVertex(destiny, source, distance);
        }
    }

    public int getVertexValue(int source, int destiny) {
        if (source >= destiny) {
            return graph.get(source).get(destiny);
        } else {
            return getVertexValue(destiny, source);
        }
    }

    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer) {
        int n = graph.size();
        for (int i = 0; i < n; i++) {
            int distance = getVertexValue(node, i);
            if (!Utils.isSentinel(distance)) {
                consumer.accept(i, distance);
            }
        }
    }

    public void print() {
        System.out.println("BidirecionalGraphMatrix2()");
        Utils.printMatrix(graph);
    }
}
