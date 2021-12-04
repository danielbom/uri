package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Utils;

public class BidirectionalGraphMatrix implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix(int capacity) {
        graph = Utils.makeMatrix(capacity);
    }

    public void addVertex(Integer source, Integer destiny, Integer distance) {
        graph.get(source).set(destiny, distance);
        graph.get(destiny).set(source, distance);
    }

    public Integer getVertexValue(Integer source, Integer destiny) {
        return graph.get(source).get(destiny);
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
        System.out.println("BidirectionalGraphMatrix()");
        Utils.printMatrix(graph);
    }
}
