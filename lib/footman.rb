# http://classic.battle.net/war3/human/units/footman.shtml
require_relative 'unit'

class Footman < Unit
  def initialize(health_points = 60, attack_power = 10)
    super(health_points, attack_power)
  end
end