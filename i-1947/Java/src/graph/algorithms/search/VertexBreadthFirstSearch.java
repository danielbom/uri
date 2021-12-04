package graph.algorithms.search;

import java.util.*;
import graph.structures.GraphAccessor;

public class VertexBreadthFirstSearch extends VertexSearchTemplate {
    public VertexBreadthFirstSearch(GraphAccessor theGraph) {
        super(theGraph);
    }

    @Override
    protected void insertToDeque(Deque<Vertex> deque, Vertex vertex) {
        deque.addLast(vertex);
    }
}
