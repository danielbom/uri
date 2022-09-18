package graph.algorithms.search;

import java.util.*;
import java.util.function.Consumer;

import graph.structures.GraphAccessor;

public class VertexAStarSearch extends VertexSearch {
    GraphAccessor graph;
    Set<Integer> visited = new HashSet<Integer>();

    public VertexAStarSearch(GraphAccessor theGraph) {
        graph = theGraph;
    }

    @Override
    public void search(Integer start, Consumer<Vertex> consumer) {
        visited.add(start);
        graph.visitAdjacentNodesOf(start, (destiny, distance) -> {
            Vertex startVertex = makeStartVertex(start, destiny, distance);
            recursiveSearch(startVertex, distance, consumer);
        });
    }

    private void recursiveSearch(Vertex vertex, Integer currentDistance, Consumer<Vertex> consumer) {
        if (filterVertex(vertex)) {
            consumer.accept(vertex);
        }

        Integer source = vertex.getDestiny();
        boolean sourceWasVisited = visited.contains(source);
        if (!sourceWasVisited) {
            visited.add(source);
            graph.visitAdjacentNodesOf(source, (destiny, distance) -> {
                Integer newDistance = currentDistance + distance;
                Vertex nextVertex = makeVertex(vertex, destiny, newDistance);

                if (!pruningHeuristic(nextVertex)) {
                    recursiveSearch(nextVertex, newDistance, consumer);
                }
            });
            visited.remove(source);
        }
    }

    public boolean pruningHeuristic(Vertex vertex) {
        return false;
    }

    public boolean filterVertex(Vertex vertex) {
        return true;
    }
}
