package graph.algorithms.search;

import java.util.*;
import graph.structures.GraphAccessor;

public class VertexDepthFirstSearch extends VertexSearchTemplate {
    public VertexDepthFirstSearch(GraphAccessor theGraph) {
        super(theGraph);
    }

    @Override
    protected void insertToDeque(Deque<Vertex> deque, Vertex vertex) {
        deque.addFirst(vertex);
    }
}
