package graph.algorithms.search;

import java.util.*;
import java.util.function.Consumer;

import graph.structures.GraphAccessor;

public abstract class VertexSearchTemplate extends VertexSearch {
    GraphAccessor graph;

    public VertexSearchTemplate(GraphAccessor theGraph) {
        graph = theGraph;
    }

    protected abstract void insertToDeque(Deque<Vertex> deque, Vertex vertex);

    public void search(Integer start, Consumer<Vertex> consumer) {
        Set<VisitedVertex> visited = new HashSet<VisitedVertex>();
        Deque<Vertex> deque = new LinkedList<Vertex>();

        graph.visitAdjacentNodesOf(start, (node, distance) -> {
            insertToDeque(deque, makeStartVertex(start, node, distance));
            visited.add(new VisitedVertex(start, node));
        });

        while (!deque.isEmpty()) {
            Vertex current = deque.pollFirst();
            consumer.accept(current);
            Integer destiny = current.getDestiny();

            graph.visitAdjacentNodesOf(destiny, (node, distance) -> {
                VisitedVertex visitedVertex = new VisitedVertex(destiny, node);
                if (!visited.contains(visitedVertex)) {
                    visited.add(visitedVertex);
                    insertToDeque(deque, makeVertex(current, node, distance));
                }
            });
        }
    }
}
