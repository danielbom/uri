package graph.algorithms.search;

import java.util.*;

import graph.structures.GraphAccessor;

public class NodeBreadthFirstSearch extends NodeSearchTemplate {
    public NodeBreadthFirstSearch(GraphAccessor theGraph) {
        super(theGraph);
    }

    @Override
    protected void insertToDeque(Deque<Node> deque, Node node) {
        deque.addLast(node);
    }
}
