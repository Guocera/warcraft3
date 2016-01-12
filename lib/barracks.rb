class Barracks
  attr_accessor :gold, :food

  def initialize
    @gold = 1000
    @food = 80
  end

  def can_train_footman?
    true
  end

  def train_footman
    self.gold -= 135
    self.food -= 2
    Footman.new
  end
end
