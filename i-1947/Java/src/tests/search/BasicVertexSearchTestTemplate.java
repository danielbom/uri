package tests.search;

import java.util.*;

import graph.algorithms.search.*;
import graph.structures.*;
import tests.core.*;

public abstract class BasicVertexSearchTestTemplate {
    private class ExpectedVertex {
        private Integer source;
        private Integer destiny;
        private Integer distance;
        private Integer depth;

        public ExpectedVertex(Integer theSource, Integer theDestiny, Integer theDistance, Integer theDepth) {
            source = theSource;
            destiny = theDestiny;
            distance = theDistance;
            depth = theDepth;
        }

        public Integer getPredecessor() {
            return source;
        }

        public Integer getNode() {
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

        @Override
        public boolean equals(Object obj) {
            if (obj instanceof ExpectedVertex) {
                ExpectedVertex o = (ExpectedVertex) obj;
                return source == o.getPredecessor()
                        && destiny == o.getNode()
                        && depth == o.getDepth()
                        && distance == o.getDistance();
            }
            return false;
        }
    }

    private GraphFactory graphFactory;
    private VertexSearchFactory vertexSearchFactory;
    private VertexSearch search;
    private Graph orderedGraph;

    private int startNode;
    private List<ExpectedVertex> resultNodes = new LinkedList<>();
    private List<ExpectedVertex> expectedNodes = new LinkedList<>();
    private int nodesCount;

    public BasicVertexSearchTestTemplate( //
            int theStartNode, //
            int theNodesCount, //
            VertexSearchFactory theVertexSearchFactory, //
            GraphFactory theGraphFactory //
    ) {
        startNode = theStartNode;
        nodesCount = theNodesCount;
        vertexSearchFactory = theVertexSearchFactory;
        graphFactory = theGraphFactory;
    }

    public void test() {
        String message = Test.getClassName(this);
        Test.startTestMessage(message);

        orderedGraph = graphFactory.create(nodesCount);
        createGraph();
        executeTheSearch();
        createExpectedResult();
        checkResult();

        Test.endTestMessage(message);
    }

    private void addNode(VertexSearch.Vertex node) {
        resultNodes.add(new ExpectedVertex( //
                node.getSource(), //
                node.getDestiny(), //
                node.getDistance(), //
                node.getDepth() //
        ));
    }

    private void executeTheSearch() {
        resultNodes = new LinkedList<>();
        search = vertexSearchFactory.create(orderedGraph);
        search.search(startNode, this::addNode);
    }

    private void checkResult() {
        Test.expectedEquals(expectedNodes, resultNodes);
    }

    protected void addVertex(Integer source, Integer destiny, Integer distance) {
        orderedGraph.addVertex(source, destiny, distance);
    }

    protected void addExpectedVertex(Integer predecessor, Integer node, Integer distance, Integer depth) {
        expectedNodes.add(new ExpectedVertex(predecessor, node, distance, depth));
    }

    protected abstract void createGraph();

    protected abstract void createExpectedResult();
}
