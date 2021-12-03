package graph;

public interface Graph extends GraphAccessor {
    public void addVertex(int source, int destiny, int distance);

    public void print();
}
