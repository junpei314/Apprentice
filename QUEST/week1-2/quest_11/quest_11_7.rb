# frozen_string_literal:true

# 自動販売機のクラスを定義
class VendingMachine
  attr_accessor :total_amount, :number_of_cups

  def initialize(manufacturer)
    @manufacturer = manufacturer
    @total_amount = 0
    @number_of_cups = 0
  end

  def press_button(item)
    return '金額が足りません' unless @total_amount >= item.amount

    if item.is_a?(Drink) || item.is_a?(SnackFood)
      @total_amount -= item.amount
      item.name
    elsif item.is_a?(Coffee) && @number_of_cups.positive?
      @total_amount -= item.amount
      @number_of_cups -= 1
      item.name
    end
  end

  def deposit_coin(amount)
    if amount == 100
      @total_amount += amount
    else
      puts '100円硬貨を入れてください．'
    end
  end

  def add_cup
    return @number_of_cups += 1 unless @number_of_cups >= 100
  end

  private

  def press_manufacturer_name
    puts @manufacturer
  end
end

# Itemクラスを定義
class Item
  attr_accessor :name, :amount

  def initialize(name, amount)
    @name = name
    @amount = amount
  end
end

# Drinkクラスを定義
class Drink < Item
end

# Coffeeクラスを定義
class Coffee < Item
  def initialize(name)
    super(name, 100)
    if @item_name == 'hot'
      @item_name = 'hot cup coffee'
    elsif @item_name == 'ice'
      @item_name = 'ice cup coffee'
    end
  end
end

# SnackFoodクラスを定義
class SnackFood < Item
  def initialize
    super('potate_chips', 150)
  end
end

vending_machine = VendingMachine.new('Coca-Cola')
cider = Drink.new('cider', 100)
cola = Drink.new('cola', 150)
hot_cup_coffee = Coffee.new('hot')
ice_cup_coffee = Coffee.new('ice')
potate_chips = SnackFood.new
vending_machine.press_button(hot_cup_coffee)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
vending_machine.add_cup
vending_machine.add_cup
puts vending_machine.press_button(hot_cup_coffee)
puts vending_machine.press_button(ice_cup_coffee)
puts vending_machine.press_button(cider)
puts vending_machine.press_button(cola)
puts vending_machine.press_button(potate_chips)
