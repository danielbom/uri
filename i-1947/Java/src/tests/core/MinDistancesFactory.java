package tests.core;

import graph.algorithms.MinDistances;
import graph.structures.Graph;

public interface MinDistancesFactory {
    public MinDistances create(Graph graph, Integer numberOfStreets);
}
