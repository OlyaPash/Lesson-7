require_relative 'company'

class CargoWagon < Wagon
include Company

  def initialize(type = "cargo", capacity)
    super
  end

  def occupied_volume(capacity)
    @occupied += capacity
  end

  def occupied_capacity
    @occupied
  end
  
  def free_volume
    @capacity - @occupied
  end

end
