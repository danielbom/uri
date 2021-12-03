package problem;

import java.util.*;

import graph.algorithms.MinDistances;

/**
 * Picked from
 * https://github.com/IvanIsCoding/OlympiadSolutions/blob/aeb67753f80a936c15ddede577ecdf10296ba6f2/URI/1947.cpp
 */
public class PlanTouristTravel2 implements PlanTouristTravel {
    private class Travel {
        public int source;
        public int destiny;

        Travel(int theSource, int theDestiny) {
            source = theSource;
            destiny = theDestiny;
        }
    }

    public static final int MAX_COSTS = 17;
    public static final int MAX_BEST_COSTS = (1 << 16) + 100; // + 65k

    private List<Travel> travels;
    private MinDistances minDistances;
    private int touristsCountIncremented;
    private int possibilities;
    private int totalDistance;

    private int[][] costs;
    private int[][] bestCosts;

    public PlanTouristTravel2(int touristsCount, MinDistances theMinDistances) {
        touristsCountIncremented = touristsCount + 1;
        possibilities = 1 << touristsCountIncremented;

        minDistances = theMinDistances;
        totalDistance = 0;
        costs = new int[MAX_COSTS][MAX_COSTS];
        bestCosts = new int[MAX_COSTS][MAX_BEST_COSTS];
        travels = new ArrayList<Travel>(touristsCountIncremented);
        travels.add(new Travel(0, 0));
    }

    public void addTravel(int source, int destiny) {
        travels.add(new Travel(source, destiny));
        int distance = minDistances.getMinDistance(source, destiny);
        updateDistance(distance);
    }

    public void computeMinDistance() {
        int initialPosition = 0;
        int initialBitmask = 1;
        // The initial bitmask are 1 to be used as a binary mapper
        // 0001, 0010, 0011, ...
        computeBaseCosts();
        initializeBestCosts();
        updateDistance(recursiveSolveBestCost(initialPosition, initialBitmask));
    }

    public int getTotalDistance() {
        return totalDistance;
    }

    private void computeBaseCosts() {
        for (int i = 0; i < touristsCountIncremented; i++) {
            for (int j = 0; j < touristsCountIncremented; j++) {
                int source = travels.get(i).destiny;
                int destiny = travels.get(j).source;
                int distance = minDistances.getMinDistance(source, destiny);
                costs[i][j] = distance;
            }
        }
    }

    private void initializeBestCosts() {
        for (int i = 0; i < touristsCountIncremented; i++) {
            for (int j = 0; j < possibilities; j++) {
                bestCosts[i][j] = -1;
            }
        }
    }

    private int recursiveSolveBestCost(int position, int bitmask) {
        if (isBestCostInitialized(position, bitmask)) {
            return bestCosts[position][bitmask];
        }

        if (bitmask == possibilities - 1) {
            int bestCost = costs[position][0];
            bestCosts[position][bitmask] = bestCost;
            return bestCost;
        }

        int best = (int) 1e8;
        for (int nextTourist = 0; nextTourist < touristsCountIncremented; nextTourist++) {
            int nextTouristBit = 1 << nextTourist;
            if (position != nextTourist && theNextTouristIsNotMarked(bitmask, nextTouristBit)) {
                int bitmaskMarkedTourist = bitmask | nextTouristBit;
                int nextTouristBestCost = recursiveSolveBestCost(nextTourist, bitmaskMarkedTourist);
                int nextBestCost = costs[position][nextTourist] + nextTouristBestCost;
                best = Math.min(best, nextBestCost);
            }
        }

        bestCosts[position][bitmask] = best;
        return best;
    }

    private boolean theNextTouristIsNotMarked(int bitmask, int nextTouristBit) {
        return (bitmask & nextTouristBit) == 0;
    }

    private boolean isBestCostInitialized(int position, int bitmask) {
        return bestCosts[position][bitmask] != -1;
    }

    private void updateDistance(int distance) {
        totalDistance += distance;
    }
}
