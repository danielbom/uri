package graph;

import java.util.*;
import java.util.function.BiConsumer;

public class BidirectionalGraphSparse implements Graph {
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
