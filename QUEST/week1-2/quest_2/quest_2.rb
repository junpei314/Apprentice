# puts '好きな数値を入力してください' ← putsだと改行されてしまう　改行なしはprintを使う
print '好きな数値を入力してください:'
input = gets.to_i * 2
puts "２倍の数値です:#{input}"