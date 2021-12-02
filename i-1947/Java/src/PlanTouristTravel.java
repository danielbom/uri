import java.util.*;

import graph.algorithms.MinDistances;

public class PlanTouristTravel {
    private static Map<Integer, List<Integer>> tourists;
    private Integer totalDistance;
    private Integer currentPosition;
    private MinDistances minDistances;

    public PlanTouristTravel(MinDistances theMinDistances) {
        tourists = new HashMap<Integer, List<Integer>>();
        totalDistance = 0;
        currentPosition = 0;
        minDistances = theMinDistances;
    }

    public void addTravel(Integer origin, Integer destiny) {
        if (!tourists.containsKey(origin)) {
            tourists.put(origin, new LinkedList<Integer>());
        }

        tourists.get(origin).add(destiny);
    }

    public void computeMinDistance() {
        while (hasTravel()) {
            if (hasTravelFrom(currentPosition)) {
                attendTravel();
            } else {
                findNextTravel();
            }
        }
        goToBegin();
    }

    public Integer getTotalDistance() {
        return totalDistance;
    }

    private void goToBegin() {
        updateDistanceToPosition(0);
    }

    private void attendTravel() {
        List<Integer> travels = tourists.get(currentPosition);
        Integer destiny = travels.remove(0);

        if (travels.isEmpty()) {
            tourists.remove(currentPosition);
        }

        updateDistanceToPosition(destiny);
    }

    private void findNextTravel() {
        Integer minTouristPosition = null;
        Integer minDistance = Integer.MAX_VALUE;
        for (Map.Entry<Integer, List<Integer>> entry : tourists.entrySet()) {
            Integer d = minDistances.getMinDistance(currentPosition, entry.getKey());
            if (d < minDistance) {
                minDistance = d;
                minTouristPosition = entry.getKey();
            }
        }
        if (minTouristPosition != null) {
            updateDistanceToPosition(minTouristPosition, minDistance);
        }
    }

    private boolean hasTravel() {
        return !tourists.isEmpty();
    }

    private boolean hasTravelFrom(Integer position) {
        return tourists.containsKey(position);
    }

    private void updateDistanceToPosition(Integer position) {
        Integer minDistance = minDistances.getMinDistance(currentPosition, position);
        updateDistanceToPosition(position, minDistance);
    }

    private void updateDistanceToPosition(Integer position, Integer minDistance) {
        updateCurrentPosition(position);
        updateDistance(minDistance);
    }

    private void updateDistance(Integer minDistance) {
        totalDistance += minDistance;
    }

    private void updateCurrentPosition(Integer position) {
        currentPosition = position;
    }
}
