a = 1
b = 2
c = [3,4]
d = 5

def test(a, b, c, d)
  a = b
  c << d
end

test(a, b, c, d)
a = b
puts a
puts c