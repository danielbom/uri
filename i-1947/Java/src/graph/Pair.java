package graph;

public class Pair<F extends Comparable<F>, S extends Comparable<S>> //
        implements Comparable<Pair<F, S>> {
    private F first;
    private S second;

    public Pair(F theFirst, S theSecond) {
        first = theFirst;
        second = theSecond;
    }

    public F getFirst() {
        return first;
    }

    public S getSecond() {
        return second;
    }

    public void setFirst(F first) {
        this.first = first;
    }

    public void setSecond(S second) {
        this.second = second;
    }

    @Override
    public int hashCode() {
        int s = first.hashCode();
        int d = second.hashCode();
        return (int) (s ^ (s >> 32)) + (d ^ (d >> 32));
    }

    @Override
    public String toString() {
        String className = getClass().getSimpleName();
        return className + "(" + first + ", " + second + ")";
    }

    @Override
    public int compareTo(Pair<F, S> o) {
        int c1 = first.compareTo(o.getFirst());
        if (c1 == 0) {
            return second.compareTo(o.getSecond());
        } else {
            return c1;
        }
    }

    public static <F extends Comparable<F>, S extends Comparable<S>> //
    boolean equals(Pair<F, S> lhs, Pair<F, S> rhs) {
        boolean isReferenceEquals = lhs == rhs;
        if (isReferenceEquals) {
            return true;
        } else {
            return lhs.getFirst().equals(rhs.getFirst())
                    && lhs.getSecond().equals(rhs.getSecond());
        }
    }
}
