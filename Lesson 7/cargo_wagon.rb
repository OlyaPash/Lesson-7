require_relative 'company'

class CargoWagon < Train
include Company

attr_accessor :volume

  def initialize(type = "cargo", volume)
    @type = type
    @volume = volume
  end

  def filling(take_volume)
    @remaining = @volume - take_volume
    puts "Занято: #{take_volume}"
  end

  def available_volume
    puts "Свободный объем: #{@remaining}"
  end

end