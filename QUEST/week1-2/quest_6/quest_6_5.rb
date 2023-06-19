def fibonacci(n)
    a = Array.new(n + 1, 0)
    result = []
    a.map.with_index do |k, i|
        if i >= 2 
            result[i] = result[i - 1] + result[i - 2]
        elsif i == 1
            result[i] = 1
        elsif i == 0
            result[i] = 0
        end
    end
    puts result[n]
end

fibonacci(0)
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(7)
fibonacci(30)
