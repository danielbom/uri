package tests.search;

import java.util.*;

import graph.algorithms.search.*;
import graph.structures.*;
import tests.core.*;

public abstract class BasicNodeSearchTestTemplate {
    public class ExpectedNode {
        private Integer predecessor;
        private Integer node;
        private Integer depth;

        public ExpectedNode(Integer thePredecessor, Integer theNode, Integer theDepth) {
            predecessor = thePredecessor;
            node = theNode;
            depth = theDepth;
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

        @Override
        public String toString() {
            return "Node(" + predecessor + "," + node + "," + depth + ")";
        }

        @Override
        public boolean equals(Object obj) {
            if (obj instanceof ExpectedNode) {
                ExpectedNode o = (ExpectedNode) obj;
                boolean notNullCompared = node.equals(o.getNode())
                        && depth.equals(o.getDepth());

                if (predecessor == null && o.getPredecessor() == null) {
                    return notNullCompared;
                } else if (predecessor == null || o.getPredecessor() == null) {
                    return false;
                } else {
                    return predecessor.equals(o.getPredecessor()) && notNullCompared;
                }
            }
            return false;
        }
    }

    private NodeSearchFactory nodeSearchFactory;
    private NodeSearch search;
    private Graph orderedGraph;

    private int startNode;
    private List<ExpectedNode> resultNodes = new LinkedList<>();
    private List<ExpectedNode> expectedNodes = new LinkedList<>();
    private int nodesCount;

    public BasicNodeSearchTestTemplate(int theStartNode, int theNodesCount, NodeSearchFactory theNodeSearchFactory) {
        startNode = theStartNode;
        nodesCount = theNodesCount;
        nodeSearchFactory = theNodeSearchFactory;
    }

    public void test() {
        String message = Test.getClassName(this);
        Test.startTestMessage(message);

        orderedGraph = new BidirectionalGraphMatrix2(nodesCount);
        createGraph();
        executeTheSearch();
        createExpectedResult();
        checkResult();

        Test.endTestMessage(message);
    }

    private void addNode(NodeSearch.Node node) {
        resultNodes.add(new ExpectedNode( //
                node.getPredecessor(), //
                node.getNode(), //
                node.getDepth() //
        ));
    }

    private void executeTheSearch() {
        resultNodes = new LinkedList<>();
        search = nodeSearchFactory.create(orderedGraph);
        search.search(startNode, this::addNode);
    }

    private void checkResult() {
        Test.expectedEquals(expectedNodes, resultNodes);
    }

    protected void addVertex(Integer source, Integer destiny, Integer distance) {
        orderedGraph.addVertex(source, destiny, distance);
    }

    protected void addExpectedNode(Integer predecessor, Integer node, Integer depth) {
        expectedNodes.add(new ExpectedNode(predecessor, node, depth));
    }

    protected abstract void createGraph();

    protected abstract void createExpectedResult();
}
