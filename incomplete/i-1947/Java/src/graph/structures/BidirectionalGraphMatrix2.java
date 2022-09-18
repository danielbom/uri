package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Utils;

public class BidirectionalGraphMatrix2 implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix2(int capacity) {
        createTriangleMatrixGraph(capacity);
    }

    private void createTriangleMatrixGraph(int n) {
        graph = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(i + 1);
            for (int j = i + 1; j >= 0; j--) {
                row.add(Utils.DISTANCE_SENTINEL);
            }
            graph.add(row);
        }
    }

    public void addVertex(Integer source, Integer destiny, Integer distance) {
        if (source >= destiny) {
            graph.get(source).set(destiny, distance);
        } else {
            addVertex(destiny, source, distance);
        }
    }

    public Integer getVertexValue(Integer source, Integer destiny) {
        if (source >= destiny) {
            return graph.get(source).get(destiny);
        } else {
            return getVertexValue(destiny, source);
        }
    }

    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer) {
        int n = graph.size();
        for (int i = 0; i < n; i++) {
            int distance = getVertexValue(node, i);
            if (!Utils.isSentinel(distance)) {
                consumer.accept(i, distance);
            }
        }
    }

    public void print() {
        System.out.println("BidirectionalGraphMatrix2()");
        Utils.printMatrix(graph);
    }
}
