declare -i COUNTER

COUNTER=0
while [ $COUNTER -ne 100 ]
do
((COUNTER++))
  if [ $((COUNTER % 2 )) -eq 0 ]; then
    echo $COUNTER
  fi
done