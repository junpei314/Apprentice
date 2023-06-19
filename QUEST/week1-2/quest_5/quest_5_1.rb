def greater(x, y)
    if x == y
        # xとyが同じか判定
        puts 'x == y'
    elsif x > y
        # xよりyが大きいか判定
        puts 'x > y'
    else
        # xよりyが小さいか判定
        puts 'x < y'
    end
end

greater(5, 4)
greater(-50, -40)
greater(10, 10)