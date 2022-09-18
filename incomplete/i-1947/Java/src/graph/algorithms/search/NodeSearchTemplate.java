package graph.algorithms.search;

import java.util.*;
import java.util.function.Consumer;

import graph.structures.*;

public abstract class NodeSearchTemplate extends NodeSearch {
    GraphAccessor graph;

    public NodeSearchTemplate(GraphAccessor theGraph) {
        graph = theGraph;
    }

    protected abstract void insertToDeque(Deque<Node> deque, Node node);

    public void search(Integer start, Consumer<Node> consumer) {
        Set<Integer> visited = new HashSet<Integer>();
        Deque<Node> deque = new LinkedList<Node>();

        insertToDeque(deque, makeStartNode(start));
        visited.add(start);

        while (!deque.isEmpty()) {
            Node current = deque.pollFirst();
            consumer.accept(current);

            graph.visitAdjacentNodesOf(current.getNode(), (node, distance) -> {
                if (!visited.contains(node)) {
                    visited.add(node);
                    insertToDeque(deque, makeNode(current, node, distance));
                }
            });
        }
    }
}
