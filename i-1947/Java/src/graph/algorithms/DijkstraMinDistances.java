package graph.algorithms;

import java.util.*;

import graph.Pair;
import graph.structures.Graph;

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
            if (other instanceof Vertex) {
                return Pair.equals(this, (Vertex) other);
            } else {
                return false;
            }
        }
    }

    private Map<Vertex, Integer> computed = new HashMap<Vertex, Integer>();
    private Graph graph;
    private Integer nodesCount;
    private boolean[] processed;
    private Queue<QueueItem> queue;

    public DijkstraMinDistances(Integer theNodesCount, Graph theGraph) {
        graph = theGraph;
        nodesCount = theNodesCount;
        processed = new boolean[nodesCount];
        queue = new PriorityQueue<QueueItem>(nodesCount);
    }

    public Integer getMinDistance(Integer source, Integer destiny) {
        final Vertex vertex = new Vertex(source, destiny);
        if (computed.containsKey(vertex)) {
            return computed.get(vertex);
        }

        for (int i = 0; i < nodesCount; i++) {
            processed[i] = false;
        }

        queue.add(new QueueItem(0, source));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();
            Integer itemId = item.getNode();
            Integer itemDistance = item.getDistance();

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
