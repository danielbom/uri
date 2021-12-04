package graph.structures;

public interface Graph extends GraphAccessor {
    public void addVertex(Integer source, Integer destiny, Integer distance);

    public void print();
}
