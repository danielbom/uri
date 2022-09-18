package graph.algorithms.search;

import java.util.*;
import java.util.function.Consumer;

import graph.Counter;

public abstract class NodeSearch {
    public class Node {
        private Node parent;
        private Integer predecessor;
        private Integer node;
        private Integer depth;
        private Integer distance;

        private Node(Node theParent, Integer thePredecessor, Integer theNode, Integer theDistance, Integer theDepth) {
            parent = theParent;
            predecessor = thePredecessor;
            node = theNode;
            distance = theDistance;
            depth = theDepth;
        }

        public List<Node> getPath() {
            List<Node> predecessors = new LinkedList<Node>();
            Node it = this;
            while (it != null) {
                predecessors.add(it);
                it = it.parent;
            }
            return predecessors;
        }

        public Integer getPredecessor() {
            return predecessor;
        }

        public Integer getNode() {
            return node;
        }

        public Integer getDepth() {
            return depth;
        }

        public Integer getDistance() {
            return distance;
        }

        @Override
        public String toString() {
            return "Node(" + predecessor + "," + node + "," + depth + ")";
        }
    }

    public Node makeStartNode(Integer node) {
        return new Node(null, null, node, 0, 0);
    }

    public Node makeNode(Node current, Integer node, Integer distance) {
        return new Node(current, current.getNode(), node, distance, current.getDepth() + 1);
    }

    public abstract void search(Integer start, Consumer<Node> consumer);

    public int countNodes(Integer start) {
        Counter counter = new Counter();
        search(start, (node) -> counter.increment());
        return counter.getCount();
    }
}
