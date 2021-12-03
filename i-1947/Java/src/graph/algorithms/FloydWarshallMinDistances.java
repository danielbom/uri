package graph.algorithms;

import java.util.*;

import graph.GraphAccessor;
import graph.Utils;

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
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                distances.get(i).set(j, i == j ? 0 : Integer.MAX_VALUE);
            }
            final int node = i;
            graph.visitAdjacentNodesOf(i, (j, distance) -> {
                distances.get(node).set(j, distance);
            });
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    int d1 = distances.get(i).get(k);
                    if (d1 == Integer.MAX_VALUE)
                        break;
                    int d2 = distances.get(k).get(j);
                    if (d2 == Integer.MAX_VALUE)
                        continue;
                    int distanceSum = d1 + d2;
                    if (distances.get(i).get(j) > distanceSum) {
                        distances.get(i).set(j, distanceSum);
                    }
                }
            }
        }
    }

    public int getMinDistance(int src, int dst) {
        return distances.get(src).get(dst);
    }

    public void print() {
        System.out.println("FloydWharshallMinDistance()");
        Utils.printMatrix(distances);
    }
}
