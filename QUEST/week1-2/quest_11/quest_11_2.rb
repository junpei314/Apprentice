# frozen_string_literal:true

# 自動販売機のクラスを定義
class VendingMachine
  def initialize(name)
    @name = name
  end

  def press_button
    'cider'
  end

  def press_manufacturer_name
    @name
  end
end

vending_machine = VendingMachine.new('サントリー')
puts vending_machine.press_manufacturer_name
