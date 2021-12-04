package graph.structures;

public class UnidirectionalGraphSparse extends GraphSparse {
    @Override
    public void addVertex(Integer source, Integer destiny, Integer distance) {
        addNodeIfNotExists(source).put(destiny, distance);
    }
}
