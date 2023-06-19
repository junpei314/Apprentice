# frozen_string_literal: true

# 自動販売機のクラスを定義
class VendingMachine
  def press_button
    'cider'
  end
end

vending_machine = VendingMachine.new

puts vending_machine.press_button
