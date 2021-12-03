package graph.algorithms;

import java.util.*;

import graph.GraphAccessor;
import graph.Utils;

public class FloydWarshallMinDistances implements MinDistances {
    private Integer n;
    private GraphAccessor graph;
    private List<List<Integer>> distances;

    public FloydWarshallMinDistances(Integer nodes, GraphAccessor graphAccessor) {
        distances = Utils.makeMatrix(nodes);
        graph = graphAccessor;
        n = nodes;
        preComputeDistances();
    }

    private void preComputeDistances() {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                Integer distance = graph.getVertexValue(i, j);
                if (Utils.isSentinel(distance)) {
                    distances.get(i).set(j, Integer.MAX_VALUE);
                } else {
                    distances.get(i).set(j, distance);
                }
            }
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    Integer d1 = distances.get(i).get(k);
                    if (d1 == Integer.MAX_VALUE)
                        continue;
                    Integer d2 = distances.get(k).get(j);
                    if (d2 == Integer.MAX_VALUE)
                        continue;
                    Integer distanceSum = d1 + d2;
                    if (distances.get(i).get(j) > distanceSum) {
                        distances.get(i).set(j, distanceSum);
                    }
                }
            }
        }
    }

    public Integer getMinDistance(Integer src, Integer dst) {
        return distances.get(src).get(dst);
    }

    public void print() {
        System.out.println("FloydWharshallMinDistance()");
        Utils.printMatrix(distances);
    }
}
