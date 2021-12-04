package problem;

import java.util.*;

import graph.algorithms.*;

public class PlanTouristTravel4 implements PlanTouristTravel {
    private MinDistances minDistances;
    private List<BellmanHeldKarpBestCost.Path> travels;
    private int totalDistance;

    public PlanTouristTravel4(Integer touristsCount, MinDistances theMinDistances) {
        minDistances = theMinDistances;
        totalDistance = 0;
        travels = new ArrayList<BellmanHeldKarpBestCost.Path>(touristsCount + 1);
        travels.add(BellmanHeldKarpBestCost.makePath(0, 0));
    }

    @Override
    public void addTravel(Integer source, Integer destiny) {
        travels.add(BellmanHeldKarpBestCost.makePath(source, destiny));
    }

    @Override
    public void computeMinDistance() {
        int initialPosition = 0;
        totalDistance = new BellmanHeldKarpBestCost(minDistances, travels) //
                .computeBestDistance(initialPosition);
    }

    @Override
    public int getTotalDistance() {
        return totalDistance;
    }
}
