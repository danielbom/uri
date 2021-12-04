package graph.structures;

import java.util.function.BiConsumer;

import graph.Pair;
import graph.Utils;

import java.util.*;

/**
 * Picked from
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */
public class BidirectionalGraphSparse2 implements Graph {
    private class Vertex extends Pair<Integer, Integer> {
        public Vertex(Integer node, Integer distance) {
            super(node, distance);
        }

        public Integer getNode() {
            return getFirst();
        }

        public Integer getDistance() {
            return getSecond();
        }
    }

    private List<List<Vertex>> graph;

    public BidirectionalGraphSparse2(int capacity) {
        createGraph(capacity);
    }

    private void createGraph(int size) {
        graph = new ArrayList<List<Vertex>>(size);
        for (int i = 0; i < size; i++) {
            graph.add(new ArrayList<>());
        }
    }

    @Override
    public void addVertex(Integer source, Integer destiny, Integer distance) {
        graph.get(source).add(new Vertex(destiny, distance));
        graph.get(destiny).add(new Vertex(source, distance));
    }

    @Override
    public Integer getVertexValue(Integer source, Integer destiny) {
        for (Vertex vertex : graph.get(source)) {
            if (vertex.getNode().equals(destiny)) {
                return vertex.getDistance();
            }
        }
        return Utils.DISTANCE_SENTINEL;
    }

    @Override
    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer) {
        for (Vertex vertex : graph.get(node)) {
            consumer.accept(vertex.getNode(), vertex.getDistance());
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
                    System.out.print("(" + vertex.getNode() + ", " + vertex.getNode() + ")");
                }
                System.out.println();
            }
        }
    }
}
