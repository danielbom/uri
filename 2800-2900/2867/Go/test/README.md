# Commands

```bash
# Run test with bench analysis
go.exe test -bench . -benchmem -count 20 > count-20.txt
go.exe test -bench . -benchmem -count 30 > count-30.txt

# Install benchstat
go install golang.org/x/perf/cmd/benchstat@latest

# Use benchstat to compare the results
benchstat count-20.txt count-30.txt > benchmark.txt
```

# Reference

* [Medium](https://medium.com/hyperskill/testing-and-benchmarking-in-go-e33a54b413e)