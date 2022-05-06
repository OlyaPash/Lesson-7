require_relative 'company'

class Wagon
include Company

attr_reader :type, :capacity, :occupied, :free_seat

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    @occupied = 0
    @free_seat = 1
  end

end