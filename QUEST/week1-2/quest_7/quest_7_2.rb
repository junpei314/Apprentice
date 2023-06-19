def square(numbers)
    numbers.map{|n|
    n ** 2}
end

squared_numbers = square([5, 7, 10])
print squared_numbers