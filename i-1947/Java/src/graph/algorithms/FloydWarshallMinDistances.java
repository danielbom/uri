package graph.algorithms;

import java.util.*;

import graph.Utils;
import graph.structures.GraphAccessor;

public class FloydWarshallMinDistances implements MinDistances {
    private int n;
    private GraphAccessor graph;
    private List<List<Integer>> distances;

    public FloydWarshallMinDistances(int nodes, GraphAccessor graphAccessor) {
        distances = Utils.makeMatrix(nodes);
        graph = graphAccessor;
        n = nodes;
        preComputeDistances();
    }

    private void preComputeDistances() {
        Integer max = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                distances.get(i).set(j, i == j ? 0 : max);
            }
            final int node = i;
            graph.visitAdjacentNodesOf(i, (j, distance) -> {
                distances.get(node).set(j, distance);
            });
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    Integer d1 = distances.get(i).get(k);
                    if (d1.equals(max))
                        break;
                    Integer d2 = distances.get(k).get(j);
                    if (d2.equals(max))
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
