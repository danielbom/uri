package graph;

import java.util.*;
import java.util.function.BiConsumer;

public class BidirectionalGraphMatrix implements Graph {
    private List<List<Integer>> graph;

    public BidirectionalGraphMatrix(Integer n) {
        graph = Utils.makeMatrix(n);
    }

    public void addVertex(Integer a, Integer b, Integer c) {
        graph.get(a).set(b, c);
        graph.get(b).set(a, c);
    }

    public Integer getVertexValue(Integer src, Integer dst) {
        return graph.get(src).get(dst);
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