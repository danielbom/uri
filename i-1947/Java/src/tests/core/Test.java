package tests.core;

class EqualsExpectation extends RuntimeException {
    EqualsExpectation(Object expected, Object result) {
        super("'" + expected + "' isn't equals to '" + result + "'");
    }
}

public class Test {
    public static void expectedEquals(Object expected, Object result) {
        boolean isReferenceEquals = expected == result;
        boolean isValueEquals = expected != null && result != null && expected.equals(result);
        boolean isEquals = isReferenceEquals || isValueEquals;
        if (!isEquals) {
            throw new EqualsExpectation(expected, result);
        }
    }

    public static void startTestMessage(String message) {
        System.out.println("🏁 Start test: " + message);
    }

    public static void testMessage(String message) {
        System.out.println("🚩\t" + message);
    }

    public static void endTestMessage(String message) {
        System.out.println("✅ End test: " + message + "\n");
    }

    public static void completeTest() {
        System.out.println("🥳 Tests completed!");
    }

    public static void initializeTest() {
        System.out.println("🏁 Tests started");
    }

    public static String getClassName(Object object) {
        String className = object.getClass().getName();
        int index = className.lastIndexOf('.');
        return index == -1 ? className : className.substring(index + 1);
    }
}