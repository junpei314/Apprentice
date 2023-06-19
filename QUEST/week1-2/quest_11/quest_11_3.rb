# frozen_string_literal:true

# 自動販売機のクラスを定義
class VendingMachine
  def initialize(name)
    @name = name
    @total_amount = 0
  end

  def press_button
    'cider' unless @total_amount >= 100
  end

  def deposit_coin(amount)
    @total_amount += 100 unless amount != 100
  end

  private

  def press_manufacturer_name
    @name
  end
end

vending_machine = VendingMachine.new('サントリー')
puts vending_machine.press_button
vending_machine.deposit_coin(150)
puts vending_machine.press_button
vending_machine.deposit_coin(100)
puts vending_machine.press_button
vending_machine.press_manufacturer_name
