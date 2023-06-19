def sheep(n)

    # n.times do |i|
    #     puts "羊が#{i + 1}匹"
    # # end

    # counter = 1
    # # while counter <= n
    # #     puts "羊が#{counter}匹"
    # #     counter += 1
    # # end
    # a = []

    # until n < counter
    #     # puts "羊が#{counter}匹"
    #     a << "羊が#{counter}匹"
    #     counter += 1
    # end
    # puts a

    a = Array.new(n, 0)
    result = a.map.with_index do |k, i|
        "羊が#{i + 1}匹"
    end
    puts result
end

sheep(10)


