require_relative 'company'

class PassengerWagon < Train
include Company

attr_reader :seats

  def initialize(type = "passenger", seats)
    @type = type
    @seats = seats
    @seat_num = 1
    @occupied = []
  end

  def take_seat
    @seats -= @seat_num
    @occupied << @seat_num
  end

  def occupied_seat
    puts "Занятых мест: #{@occupied.sum}"
  end

  def free_seat
    puts "Количество свободных мест в вагоне #{@seats}"
  end
end