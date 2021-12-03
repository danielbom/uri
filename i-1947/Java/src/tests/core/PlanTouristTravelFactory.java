package tests.core;

import graph.algorithms.MinDistances;
import problem.PlanTouristTravel;

public interface PlanTouristTravelFactory {
    public PlanTouristTravel create(MinDistances minDistances, Integer numberOfTourists);
}
