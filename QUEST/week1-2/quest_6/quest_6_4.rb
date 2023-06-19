def sum(x, y)
    result = 0
    # xからyの配列を作成
    a = (x..y).to_a
    # その配列をたす
    a.each {|n| result +=n }
    puts result
end

sum(10, 80)