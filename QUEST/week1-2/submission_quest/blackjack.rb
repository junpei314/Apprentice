# frozen_string_literal: true

require 'debug'
require_relative 'deck'
require_relative 'player'

# Blackjackクラスを定義
class Blackjack
  attr_accessor :answer, :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @answer = ''
  end

  def first_draw
    2.times do
      player.draw
      player.sum_card_number
    end
    2.times do
      dealer.draw
      dealer.sum_card_number
    end
    player.total_score_announce
  end

  def draw_loop_player
    if player.total_score > 21
      puts 'あなたの合計点が21を超えました。ディーラーの勝ちです。ブラックジャックを終了します。'
    else
      @answer = gets.chomp.upcase
      return unless @answer == 'Y'

      player.draw
      player.sum_card_number
      player.total_score_announce
      draw_loop_player
    end
  end

  def draw_loop_dealer
    if dealer.total_score > 21
      puts 'ディーラーの合計点が21を超えました。あなたの勝ちです。ブラックジャックを終了します。'
    elsif dealer.total_score < 17
      dealer.draw
      dealer.sum_card_number
      dealer.total_score_announce
      draw_loop_dealer
    end
  end

  def result
    puts "あなたの得点は#{player.total_score}です"
    puts "ディーラーの得点は#{dealer.total_score}です"
    if player.total_score > dealer.total_score
      puts 'あなたの勝ちです'
    else
      puts 'ディーラーの勝ちです'
    end
  end
end

player = Player.new('あなた')
dealer = Player.new('ディーラー')
blackjack = Blackjack.new(player, dealer)
puts 'ブラックジャックを開始します．'
blackjack.first_draw
blackjack.draw_loop_player
if blackjack.answer == 'N'
  puts "ディーラーの引いた2枚目のカードは#{dealer.symbols}の#{dealer.cards[1]}です．"
  dealer.total_score_announce
  blackjack.draw_loop_dealer
  dealer.total_score <= 21 && blackjack.result
end
