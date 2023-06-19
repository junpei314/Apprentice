require 'minitest/autorun'
require_relative 'quest_6_1'


class HelloTest < Minitest::Test
    def test_hello
        assert_equal 100, hello().size
        hello().each do |line|
            assert_equal 'こんにちは', line
        end
    end
end