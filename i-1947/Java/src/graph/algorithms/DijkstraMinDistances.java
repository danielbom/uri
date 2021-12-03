package graph.algorithms;

import java.util.*;

import graph.Graph;

/**
 * Picked from
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */
public class DijkstraMinDistances implements MinDistances {
    private class QueueItem implements Comparable<QueueItem> {
        public int distance;
        public int id;

        public QueueItem(int theId, int theDistance) {
            id = theId;
            distance = theDistance;
        }

        public int compareTo(QueueItem other) {
            return Integer.compare(distance, other.distance);
        }
    }

    private class Vertex {
        public int source;
        public int destiny;

        public Vertex(int theSource, int theDestiny) {
            source = theSource;
            destiny = theDestiny;
        }

        @Override
        public String toString() {
            return source + "-" + destiny;
        }

        @Override
        public int hashCode() {
            int s = source;
            int d = destiny;
            return (int) (s ^ (s >> 32)) + (d ^ (d >> 32));
        }

        @Override
        public boolean equals(Object other) {
            if (other == this)
                return true;

            if (other instanceof Vertex) {
                Vertex o = (Vertex) other;
                return source == o.source && destiny == o.destiny;
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
        queue.add(new QueueItem(source, 0));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();

            if (processed[item.id]) {
                continue;
            }

            processed[item.id] = true;
            computed.put(new Vertex(source, item.id), item.distance);

            graph.visitAdjacentNodesOf(item.id, (node, distance) -> {
                queue.add(new QueueItem(node, distance + item.distance));
            });
        }

        return computed.get(vertex);
    }
}
