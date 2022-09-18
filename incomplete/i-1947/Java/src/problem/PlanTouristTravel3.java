package problem;

import java.util.*;

import graph.*;
import graph.algorithms.MinDistances;
import graph.algorithms.search.*;
import graph.algorithms.search.VertexSearch.Vertex;
import graph.structures.*;

public class PlanTouristTravel3 implements PlanTouristTravel {
    class Travel extends Pair<Integer, Integer> {
        public Travel(Integer theFirst, Integer theSecond) {
            super(theFirst, theSecond);
        }

        public Integer getSource() {
            return getFirst();
        }

        public Integer getDestiny() {
            return getSecond();
        }
    }

    private Graph unidirectionalTravelsGraph = new UnidirectionalGraphSparse();

    private MinDistances minDistances;
    private List<Travel> travels;
    private Integer startPosition = 0;
    private Vertex bestVertex;

    public PlanTouristTravel3(Integer theTouristsCount, MinDistances theMinDistances) {
        minDistances = theMinDistances;
        travels = new ArrayList<Travel>(theTouristsCount);
    }

    private void updateTravelsGraph(Integer source, Integer destiny) {
        if (!source.equals(destiny)) {
            Integer distance = unidirectionalTravelsGraph.getVertexValue(source, destiny);
            if (!Utils.isSentinel(distance)) {
                distance = Math.min(distance, minDistances.getMinDistance(source, destiny));
            } else {
                distance = minDistances.getMinDistance(source, destiny);
            }
            unidirectionalTravelsGraph.addVertex(source, destiny, distance);
        }
    }

    @Override
    public void addTravel(Integer source, Integer destiny) {
        travels.add(new Travel(source, destiny));
        updateTravelsGraph(source, destiny);
        updateTravelsGraph(startPosition, source);
        updateTravelsGraph(destiny, startPosition);
    }

    private void linkEachTravel() {
        travels.forEach(travel1 -> {
            travels.forEach(travel2 -> {
                if (!travel1.equals(travel2)) {
                    updateTravelsGraph(travel1.getDestiny(), travel2.getSource());
                }
            });
        });
    }

    @Override
    public void computeMinDistance() {
        linkEachTravel();

        int nodesCount = new NodeDepthFirstSearch(unidirectionalTravelsGraph).countNodes(startPosition);

        Integer maxDepth = nodesCount - 1;
        VertexSearch travelsSearch = new VertexAStarSearch(unidirectionalTravelsGraph) {
            @Override
            public boolean pruningHeuristic(Vertex vertex) {
                if (bestVertex != null) {
                    if (vertex.getDepth() <= bestVertex.getDepth()) {
                        return vertex.getDistance() > bestVertex.getDistance();
                    }
                }
                return vertex.getDepth() > maxDepth
                        || (vertex.getDestiny().equals(startPosition) && !vertex.getDepth().equals(maxDepth));
            }
        };

        travelsSearch.search(startPosition, (vertex) -> {
            if (bestVertex == null) {
                updateBestVertex(vertex);
            } else if (bestVertex.getDepth() < vertex.getDepth()) {
                updateBestVertex(vertex);
            } else if (bestVertex.getDepth() == vertex.getDepth()) {
                if (vertex.getDestiny().equals(startPosition) && vertex.getDistance() < bestVertex.getDistance()) {
                    updateBestVertex(vertex);
                }
            }
        });
    }

    private void updateBestVertex(Vertex vertex) {
        bestVertex = vertex;
    }

    @Override
    public int getTotalDistance() {
        return bestVertex.getDistance();
    }
}
