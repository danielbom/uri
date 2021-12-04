package graph.algorithms.search;

import java.util.*;
import java.util.function.Consumer;

import graph.Counter;

public abstract class VertexSearch {
    public class Vertex {
        private Vertex parent;
        private Integer source;
        private Integer destiny;
        private Integer distance;
        private Integer depth;

        protected Vertex(Vertex theParent, Integer theSource, Integer theDestiny, Integer theDistance,
                Integer theDepth) {
            parent = theParent;
            source = theSource;
            destiny = theDestiny;
            distance = theDistance;
            depth = theDepth;
        }

        public List<Vertex> getPath() {
            List<Vertex> predecessors = new LinkedList<Vertex>();
            Vertex it = this;
            while (it != null) {
                predecessors.add(it);
                it = it.parent;
            }
            return predecessors;
        }

        public Integer getSource() {
            return source;
        }

        public Integer getDestiny() {
            return destiny;
        }

        public Integer getDistance() {
            return distance;
        }

        public Integer getDepth() {
            return depth;
        }

        @Override
        public String toString() {
            return "Vertex(" + source + "," + destiny + "," + distance + "," + depth + ")";
        }
    }

    public Vertex makeStartVertex(Integer source, Integer destiny, Integer distance) {
        return new Vertex(null, source, destiny, distance, 0);
    }

    public Vertex makeVertex(Vertex source, Integer destiny, Integer distance) {
        return new Vertex(source, source.getDestiny(), destiny, distance, source.getDepth() + 1);
    }

    public abstract void search(Integer start, Consumer<Vertex> consumer);

    public int countVertex(Integer start) {
        Counter counter = new Counter();
        search(start, (vertex) -> counter.increment());
        return counter.getCount();
    }
}
