require_relative 'instance_counter'

class Route
include InstanceCounter

  attr_accessor :stations, :starting_station, :end_station

  def initialize(starting_station, end_station)
    @end_station = end_station
    @stations = [starting_station, end_station]
    validate!
    puts "Построен маршрут #{stations.first.name} - #{stations.last.name}"
    register_instance
  end 

  def add_station(station)
    self.stations[-1] = station
    self.stations << @end_station
    puts "К маршруту #{stations.first.name} - #{stations.last.name} добавлена станция #{station.name}"
  end 

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Нельзя удалять первую и последнюю станции!"
    else self.stations.delete(station)
      puts "Станция #{station.name} удалена из списка!"
    end
  end 

  def show_stations
    puts "Список станций в маршруте: "
    self.stations.each { |station| puts "#{station.name}" }
    
  end

  def valid? 
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise StandardError, "Выбрана одна и так же станция" if stations.first == stations.last
  end

end