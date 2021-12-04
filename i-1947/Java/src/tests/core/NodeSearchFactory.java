package tests.core;

import graph.algorithms.search.NodeSearch;
import graph.structures.GraphAccessor;

public interface NodeSearchFactory {
    public NodeSearch create(GraphAccessor graph);
}
