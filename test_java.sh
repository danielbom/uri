function dotest() {
  echo "🚩 Test $1"
  # echo "Input:"
  # cat ../inputs/$1
  java -classpath bin Main > .output < "../inputs/$1"
  # echo "Result:"
  # cat .output
  # echo "" 

  ok=`diff .output ../outputs/$1`
  if [ ! -z "$ok" ]
  then
    echo "$ok"
    exit 1
  else 
    echo "✅ Test $1"
  fi
  rm .output
}

echo "🏁 Start tests"
javac -classpath bin -d bin -sourcepath src -Xlint:unchecked src/Main.java

if [ $? -ne 0 ]; then
    echo "Compilation error"
    exit 1
fi

for filename in ../inputs/*.txt
do
  dotest `basename $filename`
done

rm bin -r 
echo "🥳 Complete!"
