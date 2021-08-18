function dotest() {
  echo "🚩 Test $1"
  echo "Input:"
  cat ../inputs/$1
  ./main > .output < "../inputs/$1"
  echo "Result:"
  cat .output
  echo "" 

  ok=`diff .output ../outputs/$1`
  if [ ! -z "$ok" ]
  then
    echo "$ok"
    exit 1
  fi
  rm .output
}

echo "🏁 Start tests"
rustc main.rs

for filename in ../inputs/*.txt
do
  dotest `basename $filename`
done

rm main
echo "🥳 Complete!"
