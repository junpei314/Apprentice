echo "Enter two numbers:"
read x
read y
echo "Choose an arithmetic operation (+, -, *, /)"
read operation
case $operation in
	"+" )
	echo "The result:$((x + y))"
	;;

	"-" )
	echo "The result:$((x - y))"
	;;

	"*" )
	echo "The result:$((x * y))"
	;;

	"/" )
		if [ $y -eq 0 ]; then
			echo "0で割ることはできません。"
		else
			echo "The result:$((x / y))"
		fi
	;;

	* )
	echo "指定された演算子を入力しされた演算子を入力してください"
esac	
