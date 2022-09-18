package graph.structures;

public class BidirectionalGraphSparse extends GraphSparse {
    @Override
    public void addVertex(Integer source, Integer destiny, Integer distance) {
        addNodeIfNotExists(source).put(destiny, distance);
        addNodeIfNotExists(destiny).put(source, distance);
    }
}
