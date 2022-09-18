package graph.algorithms.search;

import graph.Pair;

public class VisitedVertex extends Pair<Integer, Integer> {
    public VisitedVertex(Integer source, Integer destiny) {
        super(source, destiny);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof VisitedVertex) {
            return Pair.equals(this, (VisitedVertex) obj);
        } else {
            return false;
        }
    }
}
