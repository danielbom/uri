package problem;

import java.util.*;

import graph.algorithms.MinDistances;

public class PlanTouristTravel1 implements PlanTouristTravel {
    private Map<Integer, List<Integer>> tourists;
    private int totalDistance;
    private int currentPosition;
    private MinDistances minDistances;

    public PlanTouristTravel1(MinDistances theMinDistances) {
        tourists = new HashMap<Integer, List<Integer>>();
        totalDistance = 0;
        currentPosition = 0;
        minDistances = theMinDistances;
    }

    public void addTravel(int origin, int destiny) {
        if (!tourists.containsKey(origin)) {
            tourists.put(origin, new ArrayList<Integer>());
        }

        tourists.get(origin).add(destiny);
    }

    public void computeMinDistance() {
        while (hasTravels()) {
            if (hasTravelFrom(currentPosition)) {
                attendTravel();
            } else {
                findNextTravel();
            }
        }
        goToBegin();
    }

    public int getTotalDistance() {
        return totalDistance;
    }

    private void goToBegin() {
        updateDistanceFromPosition(0);
    }

    private void attendTravel() {
        List<Integer> travels = tourists.get(currentPosition);
        int destiny = travels.remove(0);

        if (travels.isEmpty()) {
            tourists.remove(currentPosition);
        }

        updateDistanceFromPosition(destiny);
    }

    private void findNextTravel() {
        Integer minTouristPosition = null;
        Integer minDistance = Integer.MAX_VALUE;
        for (Map.Entry<Integer, List<Integer>> entry : tourists.entrySet()) {
            Integer distance = minDistances.getMinDistance(currentPosition, entry.getKey());
            if (distance < minDistance) {
                minDistance = distance;
                minTouristPosition = entry.getKey();
            }
        }
        if (minTouristPosition != null) {
            updateDistanceFromPosition(minTouristPosition, minDistance);
        }
    }

    private boolean hasTravels() {
        return !tourists.isEmpty();
    }

    private boolean hasTravelFrom(Integer position) {
        return tourists.containsKey(position);
    }

    private void updateDistanceFromPosition(Integer position) {
        Integer minDistance = minDistances.getMinDistance(currentPosition, position);
        updateDistanceFromPosition(position, minDistance);
    }

    private void updateDistanceFromPosition(Integer position, Integer minDistance) {
        currentPosition = position;
        totalDistance += minDistance;
    }
}
