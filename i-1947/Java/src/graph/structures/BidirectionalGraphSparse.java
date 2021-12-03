package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Graph;
import graph.Utils;

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
    public void addVertex(int source, int destiny, int distance) {
        addNodeIfNotExists(source).put(destiny, distance);
        addNodeIfNotExists(destiny).put(source, distance);
    }

    @Override
    public int getVertexValue(int src, int dst) {
        Map<Integer, Integer> attach = graph.get(src);
        if (attach == null) {
            return Utils.DISTANCE_SENTINEL;
        } else {
            Integer distance = attach.get(dst);
            return distance == null ? Utils.DISTANCE_SENTINEL : distance;
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
    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer) {
        Map<Integer, Integer> attach = graph.get(node);
        if (attach != null) {
            attach.forEach(consumer);
        }
    }
}
