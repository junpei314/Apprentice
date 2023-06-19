# frozen_string_literal:true

# 自動販売機のクラスを定義
class VendingMachine
  def initialize(name)
    @name = name
    @total_amount = 0
    @coffee_cup_count = 0
  end

  def press_button(drink)
    return '' unless @total_amount >= drink.amount

    if drink.is_a?(Drink) || drink.is_a?(SnackFood)
      @total_amount -= drink.amount
      drink.item_name
    elsif drink.is_a?(CupCoffee) && @coffee_cup_count.positive?
      @total_amount -= drink.amount
      @coffee_cup_count -= 1
      drink.item_name
    end
  end

  def deposit_coin(deposit_amount)
    @total_amount += 100 unless deposit_amount != 100
  end

  def add_cup(add_cup)
    @coffee_cup_count += add_cup unless @coffee_cup_count >= 100
  end

  private

  def press_manufacturer_name
    @name
  end
end

# アイテムクラスの定義
class Item
  attr_accessor :amount, :item_name

  def initialize(item_name)
    @amount = 0
    @item_name = item_name
  end
end

# Drinkクラスの定義
class Drink < Item
  def initialize(item_name)
    super
    if @item_name == 'cider'
      @amount = 100
    elsif @item_name == 'cola'
      @amount = 150
    end
  end
end

# カップコーヒークラスの定義
class CupCoffee < Item
  def initialize(item_name)
    super
    if @item_name == 'hot'
      @item_name = 'hot cup coffee'
      @amount = 100
    elsif @item_name == 'ice'
      @item_name = 'ice cup coffee'
      @amount = 100
    end
  end
end

# スナックフードクラスの定義
class SnackFood < Item
  def initialize(item_name)
    super
    @item_name = item_name
    @amount = 150
  end
end

hot_cup_coffee = CupCoffee.new('hot')
cider = Drink.new('cider')
snack = SnackFood.new('potato chips')
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)
puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)
puts vending_machine.press_button(snack)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(snack)
