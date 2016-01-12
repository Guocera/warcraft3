class Barracks
  attr_accessor :gold, :food, :health_points, :lumber

  def initialize
    @gold = 1000
    @food = 80
    @health_points = 500
    @lumber = 500
  end

  def damage(dmg)
    self.health_points -= dmg
  end

  def dead?
    true if health_points <= 0
  end

  def can_train_siege_engine?
    gold >= 200 && lumber >= 60 && food >= 3
  end

  def train_siege_engine
    if can_train_siege_engine?
      self.gold -= 200
      self.lumber -= 60
      self.food -= 3
      SiegeEngine.new
    end
  end

  def can_train_footman?
    gold >= 135 && food >=2
  end

  def train_footman
    if can_train_footman?
      self.gold -= 135
      self.food -= 2
      Footman.new
    end
  end

  def can_train_peasant?
    gold >= 90 && food >=5
  end

  def train_peasant
    if can_train_peasant?
      self.gold -= 90
      self.food -= 5
      Peasant.new
    end
  end

end