package graph.structures;

import java.util.function.BiConsumer;

import graph.Graph;
import graph.Utils;

import java.util.*;

/**
 * Picked from
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */
public class BidirectionalGraphSparse2 implements Graph {
    private class Vertex {
        public Integer node;
        public Integer distance;

        public Vertex(Integer theNode, Integer theDistance) {
            node = theNode;
            distance = theDistance;
        }
    }

    public static final Integer MAX_NODES = (int) 1e4 + 10;

    private List<List<Vertex>> graph;

    public BidirectionalGraphSparse2(Integer size) {
        createGraph(size);
    }

    private void createGraph(Integer size) {
        graph = new ArrayList<List<Vertex>>(size);
        for (int i = 0; i < size; i++) {
            graph.add(new ArrayList<>());
        }
    }

    @Override
    public void addVertex(int source, int destiny, int distance) {
        graph.get(source).add(new Vertex(destiny, distance));
        graph.get(destiny).add(new Vertex(source, distance));
    }

    @Override
    public int getVertexValue(int source, int destiny) {
        for (Vertex vertex : graph.get(source)) {
            if (vertex.node == destiny) {
                return vertex.distance;
            }
        }
        return Utils.DISTANCE_SENTINEL;
    }

    @Override
    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer) {
        for (Vertex vertex : graph.get(node)) {
            consumer.accept(vertex.node, vertex.distance);
        }
    }

    @Override
    public void print() {
        System.out.println("BidirectionalGraphSparse2()");
        int n = graph.size();
        for (int i = 0; i < n; i++) {
            if (!graph.get(i).isEmpty()) {
                System.out.print(i + " => ");
                for (Vertex vertex : graph.get(i)) {
                    System.out.print("(" + vertex.node + ", " + vertex.distance + ")");
                }
                System.out.println();
            }
        }
    }
}
