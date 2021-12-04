package graph.structures;

import java.util.*;
import java.util.function.BiConsumer;

import graph.Utils;

public abstract class GraphSparse implements Graph {
    private Map<Integer, Map<Integer, Integer>> graph;

    public GraphSparse() {
        graph = new HashMap<Integer, Map<Integer, Integer>>();
    }

    protected Map<Integer, Integer> addNodeIfNotExists(Integer node) {
        Map<Integer, Integer> attach = graph.get(node);
        if (attach == null) {
            attach = new HashMap<Integer, Integer>();
            graph.put(node, attach);
        }
        return attach;
    }

    @Override
    public Integer getVertexValue(Integer src, Integer dst) {
        Map<Integer, Integer> attach = graph.get(src);
        if (attach == null) {
            return Utils.DISTANCE_SENTINEL;
        } else {
            Integer distance = attach.get(dst);
            return distance == null ? Utils.DISTANCE_SENTINEL : distance;
        }
    }

    @Override
    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer) {
        Map<Integer, Integer> attach = graph.get(node);
        if (attach != null) {
            attach.forEach(consumer);
        }
    }

    @Override
    public void print() {
        String className = getClass().getSimpleName();
        System.out.println(className + "()");
        graph.forEach((src, attach) -> {
            System.out.print(src + " => ");
            attach.forEach((dst, distance) -> {
                System.out.print("(" + dst + ", " + distance + ")");
            });
            System.out.println();
        });
    }
}
