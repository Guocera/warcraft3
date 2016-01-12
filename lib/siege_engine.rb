require_relative 'unit'
class SiegeEngine < Unit
  def initialize(health_points = 400, attack_power = 50)
    super(health_points, attack_power)
  end
end