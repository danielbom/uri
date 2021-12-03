package graph;

import java.util.*;
import java.util.function.BiConsumer;

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
