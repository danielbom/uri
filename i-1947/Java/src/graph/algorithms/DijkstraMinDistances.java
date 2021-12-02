package graph.algorithms;

import java.util.*;

import graph.Graph;

public class DijkstraMinDistances implements MinDistances {
    class QueueItem implements Comparable<QueueItem> {
        public Integer distance;
        public Integer node;

        public QueueItem(Integer d, Integer n) {
            distance = d;
            node = n;
        }

        public int compareTo(QueueItem other) {
            return distance.compareTo(other.distance);
        }

        @Override
        public String toString() {
            return "QueueItem(node=" + node + ", distance=" + distance + ")";
        }
    }

    class Vertex {
        public Integer src;
        public Integer dst;

        public Vertex(Integer s, Integer d) {
            src = s;
            dst = d;
        }

        @Override
        public String toString() {
            return src + "-" + dst;
        }

        @Override
        public int hashCode() {
            int s = src.hashCode();
            int d = dst.hashCode();
            return (int) (s ^ (s >> 32)) + (d ^ (d >> 32));
        }

        @Override
        public boolean equals(Object other) {
            if (other == this)
                return true;

            if (other instanceof Vertex) {
                Vertex o = (Vertex) other;
                return src == o.src && dst == o.dst;
            } else {
                return false;
            }
        }
    }

    private Map<Vertex, Integer> computed;
    private Graph graph;
    private Integer n;

    public DijkstraMinDistances(Integer nodes, Graph theGraph) {
        computed = new HashMap<Vertex, Integer>();
        graph = theGraph;
        n = nodes;
    }

    public Integer getMinDistance(Integer src, Integer dst) {
        final Vertex vertex = new Vertex(src, dst);
        if (computed.containsKey(vertex)) {
            return computed.get(vertex);
        }

        boolean[] processed = new boolean[n];
        for (int i = 0; i < n; i++) {
            processed[i] = false;
        }

        Queue<QueueItem> queue = new PriorityQueue<QueueItem>();
        queue.add(new QueueItem(0, src));

        while (!queue.isEmpty()) {
            QueueItem item = queue.poll();

            if (processed[item.node]) {
                continue;
            }

            processed[item.node] = true;
            computed.put(new Vertex(src, item.node), item.distance);

            graph.visitAdjacentNodesOf(item.node, (node, distance) -> {
                queue.add(new QueueItem(distance + item.distance, node));
            });
        }

        return computed.get(vertex);
    }
}
