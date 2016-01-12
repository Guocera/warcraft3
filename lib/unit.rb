class Unit
  attr_accessor :health_points, :attack_power, :damage

  def initialize(health_points, attack_power)
    @health_points = health_points
    @attack_power = attack_power
  end

  def attack!(enemy)
    case enemy
    when Barracks
      dmg = attack_power / 2.0
    when Unit
      dmg = attack_power
    end
    enemy.damage(dmg)
  end

  def damage(dmg)
    self.health_points -= dmg
  end

  def dead?
    true if health_points <= 0
  end

end