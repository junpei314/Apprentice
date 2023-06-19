def train_fare(age)
    # 12歳以上か判定して処理
    if age >= 12
        puts 200
        # 6歳以上か判定して処理
    elsif age >= 6
        puts 100
        # それ以外の処理
    else
        puts 0
    end
end


train_fare(12)
train_fare(6)
train_fare(5)