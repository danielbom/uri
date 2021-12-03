package graph;

import java.util.function.BiConsumer;

public interface GraphAccessor {
    public int getVertexValue(int source, int destiny);

    public void visitAdjacentNodesOf(int node, BiConsumer<Integer, Integer> consumer);
}
