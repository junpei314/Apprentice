def calculate(num1, num2, operator)
    numbers = [num1, num2]
    integers = numbers.map do |number|
        if number == number.to_i
            number.to_i
        else
            raise puts 'num1, num2には整数を入力してください'
        end
    end

    num1, num2 = integers

    if operator == '+'
        puts num1 + num2

    elsif operator == '-'
        puts num1 - num2
        
    elsif operator == '*'
        puts num1 * num2
        
    elsif operator == '/'
        puts num1 / num2
    else
        raise puts '演算子には  +、-、*、/ のいずれかを使用してください'
    end
end
  
puts "1番目の整数を入力してください:"
num1 = gets.chomp.to_f

puts "2番目の整数を入力してください:"
num2 = gets.chomp.to_f

puts "演算子(+, -, *, /)を入力してください:"
operator = gets.chomp

begin
    result = calculate(num1, num2, operator)
    puts result
rescue ZeroDivisionError
    puts "ゼロによる割り算は許可されていません"
end