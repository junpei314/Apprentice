require 'minitest/autorun'
require_relative 'sheep'

class SheepTest < Minitest::Test
    def test_sheep
        assert_equal 10, sheep(10).size
        counter = 1
        until 10 > counter
            assert_equal "羊が#{counter}匹",  
            counter += 1
        end
    end
end

# 作成途中
