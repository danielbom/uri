package tests.core;

public class Timer {
    static long startTime, endTime;

    public void startTimer() {
        startTime = System.nanoTime();
    }

    public void endTimer() {
        endTime = System.nanoTime();
    }

    public long getTotalTimeNanoseconds() {
        return endTime - startTime;
    }

    public double getTotalTimeSeconds() {
        return (double) getTotalTimeNanoseconds() / 1e9;
    }
}
