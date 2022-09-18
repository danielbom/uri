# https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/tooldescr006.html
# https://stackoverflow.com/questions/41891127/jcmd-where-can-i-find-complementary-information

set -e

PROF_DIR="prof"

mkdir $PROF_DIR -p

echo "🔘 Test input: '$1'"

javac -classpath bin -d bin -sourcepath src -Xlint:unchecked src/Main.java
java -classpath bin Main > .output < "$1" &
BACK_PID=$!

JAVA_PID=`ps aux | grep "java -classpath bin Main" | head -n 1`
JAVA_PID=`python -c "import re; print(re.split(r'\s+', '$JAVA_PID')[1])"`
echo "📌 Java PID: $JAVA_PID"

COUNT=0
OK=0
while [[ COUNT -lt 10 ]] && [[ "$OK" -eq "0" ]]
do 
  COUNT=$((COUNT + 1))
  echo "⏱  Check execution: $COUNT"
  set +e
  jcmd $JAVA_PID GC.class_histogram > "$PROF_DIR/hist-$COUNT.txt" 2> /dev/null
  OK=$?
  set -e
  sleep 1
done

if [[ "$OK" -ne "0" ]]
then
  COUNT=$((COUNT - 1))
  rm "$PROF_DIR/hist-$COUNT.txt"
fi

set +e
kill $JAVA_PID 2> /dev/null
if [[ "$?" -eq "0" ]]
then 
  echo "💥 Execution killed!"
else
  echo "👍 Execution result:"
  cat .output
fi
set -e

rm bin -r
rm .output
