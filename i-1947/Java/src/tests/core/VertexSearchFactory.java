package tests.core;

import graph.algorithms.search.VertexSearch;
import graph.structures.GraphAccessor;

public interface VertexSearchFactory {
    public VertexSearch create(GraphAccessor graph);
}
