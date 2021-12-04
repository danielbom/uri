package tests.basics.problem;

import graph.*;
import graph.algorithms.*;
import problem.PlanTouristTravel;
import tests.core.*;

public abstract class PlanTouristTravelTestTemplate {
    private GraphFactory graphFactory;
    private MinDistancesFactory minDistancesFactory;
    private PlanTouristTravelFactory planTouristTravelFactory;

    private Graph graph;
    private MinDistances minDistances;
    private PlanTouristTravel planTouristTravel;

    public PlanTouristTravelTestTemplate( //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory, //
            PlanTouristTravelFactory thePlanTouristTravelFactory //
    ) {
        graphFactory = theGraphFactory;
        minDistancesFactory = theMinDistancesFactory;
        planTouristTravelFactory = thePlanTouristTravelFactory;
    }

    protected void addVertex(int source, int destiny, int distance) {
        graph.addVertex(source, destiny, distance);
    }

    protected void addTravel(int origin, int destiny) {
        planTouristTravel.addTravel(origin, destiny);
    }

    private void computeDistance() {
        planTouristTravel.computeMinDistance();
    }

    private void checkDistance() {
        int result = planTouristTravel.getTotalDistance();
        int expectedResult = getExpectedResult();
        Test.testMessage("The excepted value was '" + expectedResult + "'");
        Test.testMessage("The result value was '" + result + "'");
        Test.expectedEquals(expectedResult, result);
    }

    public void test() {
        Timer timer = new Timer();
        timer.startTimer();

        int touristsCount = getTouristsCount();
        int streetsCount = getStreetLimit();

        Test.startTestMessage(Test.getClassName(this));
        Test.testMessage("Street count: " + streetsCount);

        graph = graphFactory.create(streetsCount);
        buildGraph();

        Test.testMessage("Tourists count: " + touristsCount);
        minDistances = minDistancesFactory.create(graph, streetsCount);
        planTouristTravel = planTouristTravelFactory.create(minDistances, touristsCount);
        addTouristsTravel();

        String planTouristTravelName = Test.getClassName(planTouristTravel);
        String graphName = Test.getClassName(graph);
        String minDistancesName = Test.getClassName(minDistances);
        String message = planTouristTravelName + " w/ " + graphName + " w/ " + minDistancesName;

        Test.testMessage(message);
        computeDistance();
        checkDistance();

        timer.endTimer();
        Test.endTestMessage(message + " :: time " + timer.getTotalTimeSeconds() + " seconds");
    }

    protected abstract void buildGraph();

    protected abstract void addTouristsTravel();

    protected abstract int getStreetLimit();

    protected abstract int getTouristsCount();

    protected abstract int getExpectedResult();
}
