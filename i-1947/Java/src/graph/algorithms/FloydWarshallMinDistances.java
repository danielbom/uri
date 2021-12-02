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
                Integer c = graph.getVertexValue(i, j);
                Integer v = c == 0 && i != j ? 101 : c;
                distances.get(i).set(j, v);
            }
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    Integer distanceSum = distances.get(i).get(k) + distances.get(k).get(j);
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
