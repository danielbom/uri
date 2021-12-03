package tests.core;

import graph.Graph;
import graph.algorithms.MinDistances;

public interface MinDistancesFactory {
    public MinDistances create(Graph graph, Integer numberOfStreets);
}
