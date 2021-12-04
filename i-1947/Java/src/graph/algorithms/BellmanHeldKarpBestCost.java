package graph.algorithms;

import java.util.*;

import graph.Pair;

/**
 * References:
 * * Travelling Salesman Problem and Bellman-Held-Karp
 * Algorithm: http://www.math.nagoya-u.ac.jp/~richard/teaching/s2020/Quang1.pdf
 * * Hamiltonian Path:
 * https://www.hackerearth.com/practice/algorithms/graphs/hamiltonian-path/tutorial/
 */
public class BellmanHeldKarpBestCost {
    public static class Path extends Pair<Integer, Integer> {
        Path(Integer source, Integer destiny) {
            super(source, destiny);
        }

        public int getSource() {
            return getFirst();
        }

        public int getDestiny() {
            return getSecond();
        }
    }

    private MinDistances minDistances;

    private List<Path> paths;
    private int[][] costs;
    private int[][] bestCosts;
    private int pathsCount;
    private int possibilities;
    private int totalDistance;

    public BellmanHeldKarpBestCost(MinDistances theMinDistances, List<Path> thePaths) {
        paths = new ArrayList<Path>(thePaths);
        minDistances = theMinDistances;

        pathsCount = paths.size();
        possibilities = 1 << pathsCount;
        costs = new int[pathsCount][pathsCount];
        bestCosts = new int[pathsCount][possibilities];
    }

    public static Path makePath(Integer source, Integer destiny) {
        return new Path(source, destiny);
    }

    public int computeBestDistance(int initialPosition) {
        int initialBitmask = 1;
        updateBaseDistance();
        computeBaseCosts();
        initializeBestCosts();
        updateDistance(recursiveSolveBestCost(initialPosition, initialBitmask));
        return totalDistance;
    }

    private void updateBaseDistance() {
        for (int i = 0; i < pathsCount; i++) {
            int source = paths.get(i).getSource();
            int destiny = paths.get(i).getDestiny();
            int pathDistance = minDistances.getMinDistance(source, destiny);
            updateDistance(pathDistance);
        }
    }

    private void computeBaseCosts() {
        for (int i = 0; i < pathsCount; i++) {
            for (int j = 0; j < pathsCount; j++) {
                int source = paths.get(i).getDestiny();
                int destiny = paths.get(j).getSource();
                int distance = minDistances.getMinDistance(source, destiny);
                costs[i][j] = distance;
            }
        }
    }

    private void initializeBestCosts() {
        for (int i = 0; i < pathsCount; i++) {
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

        int best = Integer.MAX_VALUE;
        for (int nextNode = 0; nextNode < pathsCount; nextNode++) {
            int nextNodeBit = 1 << nextNode;
            if (position != nextNode && theNextNodeIsNotMarked(bitmask, nextNodeBit)) {
                int bitmaskMarkedNode = bitmask | nextNodeBit;
                int nextNodeBestCost = recursiveSolveBestCost(nextNode, bitmaskMarkedNode);
                int nextBestCost = costs[position][nextNode] + nextNodeBestCost;
                best = Math.min(best, nextBestCost);
            }
        }

        bestCosts[position][bitmask] = best;
        return best;
    }

    private boolean theNextNodeIsNotMarked(int bitmask, int nextNodeBit) {
        return (bitmask & nextNodeBit) == 0;
    }

    private boolean isBestCostInitialized(int position, int bitmask) {
        return bestCosts[position][bitmask] != -1;
    }

    private void updateDistance(int distance) {
        totalDistance += distance;
    }
}
