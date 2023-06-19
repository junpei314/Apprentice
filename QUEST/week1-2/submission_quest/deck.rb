# frozen_string_literal: true

# Deckクラスを定義
class Deck
  CARD = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  CARD_SET = { 'スペード' => CARD.dup, 'クローバー' => CARD.dup, 'ハート' => CARD.dup, 'ダイヤ' => CARD.dup }.freeze
end
