require_relative 'unit'
class SiegeEngine < Unit
  def initialize(health_points = 400, attack_power = 50)
    super(health_points, attack_power)
  end

  def attack!(enemy)
    return if ( dead? || enemy.dead? )
    case enemy
    when Barracks
      dmg = attack_power * 2.0
    when SiegeEngine
      dmg = attack_power
    when Unit
      dmg = 0
    end
    enemy.damage(dmg)
  end
end