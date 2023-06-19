# frozen_string_literal: true

# Participantクラスを定義
class Player
  attr_accessor :cards, :total_score, :name, :symbols

  SYMBOL = %w[J Q K].freeze

  def initialize(name)
    @cards = []
    @total_score = 0
    @name = name
    @count = 0
    @symbols = []
  end

  def draw
    symbol = Deck::CARD_SET.keys.sample
    @symbols = symbol
    card_number = Deck::CARD_SET[symbol].sample
    cards << card_number
    sort_array
    Deck::CARD_SET[symbol].delete(card_number)
    check_class(symbol, card_number)
  end

  def check_class(symbol, card_number)
    if name == 'ディーラー'
      @count += 1
      if @count == 2
        puts "#{name}の引いた2枚目のカードは分かりません。"
      else
        puts "#{name}の引いたカードは#{symbol}の#{card_number}です．"
      end
    elsif name == 'あなた'
      puts "#{name}の引いたカードは#{symbol}の#{card_number}です．"
    end
  end

  def sort_array
    return unless cards.include?('A')

    index = cards.index('A')
    deleted_number = cards.delete_at(index)
    cards.push(deleted_number)
  end

  def sum_card_number
    @total_score = 0
    cards.each do |n|
      @total_score += if SYMBOL.include?(n)
                        10
                      elsif n == 'A'
                        @total_score + 11 > 21 ? 1 : 11
                      else
                        n.to_i
                      end
    end
  end

  def total_score_announce
    if name == 'あなた'
      if total_score > 21
        puts "#{name}の現在の得点は#{@total_score}です．"
      else
        puts "#{name}の現在の得点は#{@total_score}です．カードを引きますか(Y/N)"
      end
    else
      puts "#{name}の現在の得点は#{@total_score}です．"
    end
  end
end
