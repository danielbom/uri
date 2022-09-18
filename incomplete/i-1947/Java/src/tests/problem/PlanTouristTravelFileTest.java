package tests.problem;

import java.util.*;
import java.io.*;
import java.nio.file.*;

import tests.core.*;

public class PlanTouristTravelFileTest extends PlanTouristTravelTestTemplate {
    public static class Input {
        private int expectedResult;
        private String filePath;

        public Input(String theFilePath, int theExpectedResult) {
            expectedResult = theExpectedResult;
            filePath = theFilePath;
        }

        public int getExpectedResult() {
            return expectedResult;
        }

        public String getFilePath() {
            return filePath;
        }
    }

    private Scanner scan;

    private Input input;

    private Integer streetLimit;
    private Integer streetsCount;
    private Integer touristsCount;

    public PlanTouristTravelFileTest( //
            Input theInput, //
            GraphFactory theGraphFactory, //
            MinDistancesFactory theMinDistancesFactory, //
            PlanTouristTravelFactory thePlanTouristTravelFactory //
    ) {
        super(theGraphFactory, theMinDistancesFactory, thePlanTouristTravelFactory);
        input = theInput;
        startupScanner();
        readSpecification();

    }

    @Override
    protected int getExpectedResult() {
        return input.getExpectedResult();
    }

    @Override
    protected int getStreetLimit() {
        return streetLimit;
    }

    @Override
    protected int getTouristsCount() {
        return touristsCount;
    }

    @Override
    protected void buildGraph() {
        for (int i = 0; i < streetsCount; i++) {
            List<Integer> streetLine = readInts();

            Integer origin = streetLine.get(0) - 1;
            Integer destiny = streetLine.get(1) - 1;
            Integer distance = streetLine.get(2);

            addVertex(origin, destiny, distance);
        }
    }

    @Override
    protected void addTouristsTravel() {
        for (int i = 0; i < touristsCount; i++) {
            List<Integer> touristLine = readInts();
            Integer origin = touristLine.get(0) - 1;
            Integer destiny = touristLine.get(1) - 1;
            addTravel(origin, destiny);
        }
    }

    private List<Integer> readInts() {
        String line = scan.nextLine();
        ArrayList<Integer> result = new ArrayList<Integer>(3);
        for (String item : line.split(" ")) {
            result.add(Integer.parseInt(item));
        }
        return result;
    }

    private void startupScanner() {
        try {
            InputStream inputStream = Files.newInputStream(Path.of(input.getFilePath()));
            scan = new Scanner(inputStream);
        } catch (IOException e) {
            throw new RuntimeException("Invalid test file: " + input.getFilePath());
        }
    }

    private void readSpecification() {
        List<Integer> firstLine = readInts();
        streetLimit = firstLine.get(0);
        streetsCount = firstLine.get(1);
        touristsCount = firstLine.get(2);
    }
}
