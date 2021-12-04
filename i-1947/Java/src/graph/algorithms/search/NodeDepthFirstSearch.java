package graph.algorithms.search;

import java.util.*;

import graph.structures.GraphAccessor;

public class NodeDepthFirstSearch extends NodeSearchTemplate {
    public NodeDepthFirstSearch(GraphAccessor theGraph) {
        super(theGraph);
    }

    @Override
    protected void insertToDeque(Deque<Node> deque, Node node) {
        deque.addFirst(node);
    }
}
