require_relative 'company'

class PassengerWagon < Wagon
include Company

  def initialize(type = "passenger", capacity)
    super
    @occupied = []
  end

  def take_seat
    @capacity -= @free_seat
    @occupied << @free_seat
  end

  def occupied_seat
    puts "Занятых мест: #{@occupied.sum}"
  end

  def free_seats
    puts "Количество свободных мест в вагоне #{@capacity}"
  end
end
