package tests.basics.problem;

import tests.core.*;

public class PlanTouristTravelTest2 extends PlanTouristTravelTestTemplate {
    public PlanTouristTravelTest2( //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory, //
            PlanTouristTravelFactory planTouristTravelFactory //
    ) {
        super(theGraphFactory, theMinDistancesFactory, planTouristTravelFactory);
    }

    @Override
    protected int getExpectedResult() {
        return 26;
    }

    @Override
    protected int getStreetLimit() {
        return 5;
    }

    @Override
    protected int getTouristsCount() {
        return 3;
    }

    @Override
    protected void buildGraph() {
        addVertex(0, 1, 3);
        addVertex(0, 2, 7);
        addVertex(0, 3, 5);
        addVertex(1, 2, 2);
        addVertex(2, 3, 6);
        addVertex(2, 4, 5);
        addVertex(3, 4, 3);
    }

    @Override
    protected void addTouristsTravel() {
        addTravel(1, 3);
        addTravel(3, 4);
        addTravel(0, 2);
    }
}
