def print_names(names)
    names.each_with_index { |n, i|
        puts "#{i+1}. #{n}"
    }
end

print_names(['上田', '山田', '小佐野'])