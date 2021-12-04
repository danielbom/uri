package tests.problem;

import tests.core.*;

public class PlanTouristTravelTest1 extends PlanTouristTravelTestTemplate {
    public PlanTouristTravelTest1( //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory, //
            PlanTouristTravelFactory planTouristTravelFactory //
    ) {
        super(theGraphFactory, theMinDistancesFactory, planTouristTravelFactory);
    }

    @Override
    protected int getExpectedResult() {
        return 9;
    }

    @Override
    protected int getStreetLimit() {
        return 3;
    }

    @Override
    protected int getTouristsCount() {
        return 1;
    }

    @Override
    protected void buildGraph() {
        addVertex(0, 1, 2);
        addVertex(1, 2, 4);
        addVertex(2, 0, 3);
    }

    @Override
    protected void addTouristsTravel() {
        addTravel(1, 2);
    }
}
