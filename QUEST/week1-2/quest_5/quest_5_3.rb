# def xor(x, y)
#     if x == y
#         # xとyが同じ値か判定して同じならtrueを返す
#         puts false
#     else
#         # それ以外ならfalseを返す
#         puts true
#     end
# end

def xor (x, y)
    puts (x || y) && !(x && y)
end





xor(true, true)
xor(true, false)
xor(false, true)
xor(false, false)