package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Graph;
import graph.Utils;

public class BidirectionalGraphMatrix implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix(Integer n) {
        graph = Utils.makeMatrix(n);
    }

    public void addVertex(int source, int destiny, int distance) {
        graph.get(source).set(destiny, distance);
        graph.get(destiny).set(source, distance);
    }

    public int getVertexValue(int source, int destiny) {
        return graph.get(source).get(destiny);
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
        System.out.println("BidirecionalGraphMatrix()");
        Utils.printMatrix(graph);
    }
}
