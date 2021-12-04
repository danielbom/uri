package graph.structures;

import java.util.function.BiConsumer;

public interface GraphAccessor {
    public Integer getVertexValue(Integer source, Integer destiny);

    public void visitAdjacentNodesOf(Integer node, BiConsumer<Integer, Integer> consumer);
}
