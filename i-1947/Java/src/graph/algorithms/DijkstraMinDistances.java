package graph.algorithms;

import java.util.*;

import graph.Graph;
import graph.Pair;

/**
 * Picked from
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */
public class DijkstraMinDistances implements MinDistances {
    private class QueueItem extends Pair<Integer, Integer> {
        public QueueItem(Integer distance, Integer node) {
            super(distance, node);
        }

        public Integer getNode() {
            return getSecond();
        }

        public Integer getDistance() {
            return getFirst();
        }
    }

    private class Vertex extends Pair<Integer, Integer> {
        public Vertex(Integer theFirst, Integer theSecond) {
            super(theFirst, theSecond);
        }

        @Override
        public boolean equals(Object other) {
            if (other == this) {
                return true;
            } else if (other instanceof Vertex) {
                return this.compareTo((Vertex) other) == 0;
            } else {
                return false;
            }
        }
    }

    private Map<Vertex, Integer> computed;
    private Graph graph;
    private Integer nodesCount;

    public DijkstraMinDistances(Integer theNodesCount, Graph theGraph) {
        computed = new HashMap<Vertex, Integer>();
        graph = theGraph;
        nodesCount = theNodesCount;
    }

    public int getMinDistance(int source, int destiny) {
        final Vertex vertex = new Vertex(source, destiny);
        if (computed.containsKey(vertex)) {
            return computed.get(vertex);
        }

        boolean[] processed = new boolean[nodesCount];
        for (int i = 0; i < nodesCount; i++) {
            processed[i] = false;
        }

        Queue<QueueItem> queue = new PriorityQueue<QueueItem>();
        queue.add(new QueueItem(0, source));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();
            int itemId = item.getNode();
            int itemDistance = item.getDistance();

            if (!processed[itemId]) {
                processed[itemId] = true;

                computed.put(new Vertex(source, itemId), itemDistance);

                graph.visitAdjacentNodesOf(itemId, (node, distance) -> {
                    queue.add(new QueueItem(distance + itemDistance, node));
                });
            }
        }

        return computed.get(vertex);
    }
}
