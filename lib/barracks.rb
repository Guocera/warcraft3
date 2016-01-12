class Barracks
  attr_writer :gold, :food 

  def food
    @food = 1
  end

  def gold
    @gold = 134
  end

  def initialize
    @gold = 1000
    @food = 80
  end

  def can_train_footman?
    gold >= 135 && food >=2
  end

  def train_footman
    self.gold -= 135
    self.food -= 2
    Footman.new
  end

end