package graph;

import java.util.function.BiConsumer;

public interface Graph extends GraphAccessor {
    public void addVertex(Integer src, Integer dst, Integer distance);

    public void print();

    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer);
}
