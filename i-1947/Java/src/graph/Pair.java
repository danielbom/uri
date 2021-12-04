package graph;

public class Pair<FIRST extends Comparable<FIRST>, SECOND extends Comparable<SECOND>> //
        implements Comparable<Pair<FIRST, SECOND>> {
    private FIRST first;
    private SECOND second;

    public Pair(FIRST theFirst, SECOND theSecond) {
        first = theFirst;
        second = theSecond;
    }

    public FIRST getFirst() {
        return first;
    }

    public SECOND getSecond() {
        return second;
    }

    public void setFirst(FIRST first) {
        this.first = first;
    }

    public void setSecond(SECOND second) {
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
    public int compareTo(Pair<FIRST, SECOND> o) {
        int c1 = first.compareTo(o.getFirst());
        if (c1 == 0) {
            return second.compareTo(o.getSecond());
        } else {
            return c1;
        }
    }
}
