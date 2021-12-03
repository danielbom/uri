package graph;

import java.util.*;

public class Utils {
    public static final Integer DISTANCE_SENTINEL = null;

    public static List<List<Integer>> makeMatrix(Integer n) {
        List<List<Integer>> matrix = new ArrayList<List<Integer>>(n);
        for (int i = 0; i < n; i++) {
            List<Integer> row = new ArrayList<Integer>(n);
            for (int j = 0; j < n; j++) {
                row.add(DISTANCE_SENTINEL);
            }
            matrix.add(row);
        }
        return matrix;
    }

    public static void printMatrix(List<List<Integer>> matrix) {
        matrix.forEach(row -> {
            System.out.print("[");
            int i = 0;
            for (Integer x : row) {
                if (i > 0)
                    System.out.print(",");
                System.out.print(x);
                i += 1;
            }
            System.out.println("]");
        });
    }

    public static boolean isSentinel(Integer distance) {
        return distance == DISTANCE_SENTINEL;
    }
}
