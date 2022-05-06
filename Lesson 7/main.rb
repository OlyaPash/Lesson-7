class Main

  attr_accessor :stations, :trains, :routes, :wagons, :end_station, :starting_station

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    # @end_station = end_station
    # @starting_station = starting_station
  end


  def create_station
    puts "Введите назание станции: "
    st_name = gets.chomp
    station = Station.new(st_name)
    @stations << station
  rescue ArgumentError => e
    puts "Ошибка: #{e}"
    retry
    @stations.each {|el| puts el.name}
  end

  def create_train
    puts "Введите номер для нового поезда:"
    number = gets.chomp #.to_i 
    puts "Выберите тип поезда: passenger, cargo"
    type = gets.chomp
    raise StandardError, "Неправильный тип поезда" unless type == "cargo" || type == "passenger"
    case type
      when "passenger"
        train = PassengerTrain.new(number, type)
        @trains << train
      when "cargo"
        train = CargoTrain.new(number, type)
        @trains << train
      end

    puts "Создан поезд №#{number}, тип: #{type}"
  rescue ArgumentError => e
    puts "Ошибка формата: #{e}"
    retry
  rescue StandardError => e
    puts "Ошибка: #{e}"
  end

  def create_route
    # if @stations.length < 2
    #   puts "В маршруте должно быть минимум две станции!"
    # else
      stations_list
      puts "Введите индекс станции, чтобы выбрать начальную: "
      @starting_station = gets.chomp.to_i
      first_st = @stations[@starting_station]
      puts "Введите индекс для конечной: "
      @end_station = gets.chomp.to_i
      last_st = @stations[@end_station]
      route = Route.new(first_st, last_st)
      @routes << route
    #end
    rescue StandardError => e
      puts "Ошибка: #{e}"
    
  end
  
  def add_station_route
    if @routes.empty?
      puts "Маршрут пуст!"
    else
      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}" 
      end
      puts "Выберите маршрут(индекс): "
      route = gets.to_i
      
      puts "Выберите станцию(индекс), чтобы добавить к маршруту: "
      @stations.each_with_index {|v, i| puts "#{i} - #{v.name}"}
      st_name = gets.chomp.to_i
      @routes[route].add_station(@stations[st_name])
      @routes[route].show_stations
    end
  end

  def remove_station
    if @routes.empty?
      puts "Маршрут пуст!"
    else
      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}" 
      end
      puts "Выберите маршрут: "
      route = gets.to_i
      
      puts "Выберите станцию(индекс), чтобы удалить из маршрута: "
      @stations.each_with_index {|v, i| puts "#{i} - #{v.name}"}
      st_name = gets.chomp.to_i
      @routes[route].delete_station(@stations[st_name])
      @routes[route].show_stations
    end
  end

  
  def get_route
    if @routes.empty?
      puts "В маршруте нет станций! Нужно добавить станции!"
    else
      @trains.each_with_index {|v, i| puts "Индекс:#{i} - №#{v.number}"}
      puts "Введите индекс номера поезда, которому хотите назначить маршрут: "
      train = gets.chomp.to_i

      @routes.each_with_index do |v, i| 
        puts "#{i} : #{v.stations.first.name} - #{v.stations.last.name}"
      end

      puts "Выберите маршрут: "
      route = gets.to_i

      @trains[train].received_route(@routes[route])
    end
  end

  def add_wagon_train

    if @trains.empty?
      puts "Необходимо создать поезд!"
    else 
      trains_list
      puts "Введите индекс поезда которому хотите добавить вагон: "
      train = gets.to_i
      
      case @trains[train].type 
        when "cargo"
          puts "Укажите общий объем:"
          capacity = gets.chomp.to_i
          wagon = CargoWagon.new(capacity)
          @wagons << wagon
          @trains[train].add_wagons(wagon)
        when "passenger"
          puts "Укажите количество мест в вагоне:"
          capacity = gets.chomp.to_i
          wagon = PassengerWagon.new(capacity)
          @wagons << wagon
          @trains[train].add_wagons(wagon)
      end
      
    end
  end

  def delete_wagon
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else 
      trains_list
      puts "Введите индекс поезда от которого хотите отцепить вагон: "
      train = gets.to_i
      
      @trains[train].remove_wagons  
    end
    
  end

  def info_wagons
    trains_list
    puts "Введите индекс поезда:"
    train = gets.to_i
    
      if @trains[train].wagons.any?
        puts "Выберите вагон:"
        num = 1
        @trains[train].wagons_list do |wagon|
          if wagon.class == PassengerWagon
            puts "Вагон №#{num}"
            puts "#{wagon.free_seats} #{wagon.occupied_seat}"
          else
            puts "Вагон №#{num}, занятый объем: #{wagon.occupied_capacity}"
            puts "Свободно: #{wagon.free_volume}"
          end
          num += 1
        end

        choise = gets.to_i
        wagon = @trains[train].wagons[choise - 1]

        if wagon.class == CargoWagon
          puts "Введите объем груза:"
          capacity = gets.to_i
          puts "Занято:"
          puts wagon.occupied_volume(capacity)
          puts "Свободно:" 
          puts wagon.free_volume
        else
          wagon.take_seat
          wagon.occupied_seat
          wagon.free_seats
        end
      end 
  end 

  def train_next
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else
      trains_list
      puts "Введите индекс поезда: "
      train = gets.chomp.to_i
      @trains[train].moving_next
    end 
    @trains[train].pre_curr_next
  end

  def train_back
    if @trains.empty?
      puts "Необходимо создать поезд!"
    else
      trains_list
      puts "Введите индекс поезда: "
      train = gets.chomp.to_i
      @trains[train].moving_back
    end  
    @trains[train].pre_curr_next
  end

  def trains_on_station
    @stations.each do |station|
      puts "На станции #{station.name} поезда:"
      #station.trains.each do |train|
      station.block_trains do |train| 
        puts "Поезд №#{train.number} типа: #{train.type}, количество вагонов: #{train.wagons.size}"
        # puts "№#{train.number}"
      end
    end
  end

  def stations_list
    @stations.each_with_index do |station, index| 
      puts "Индекс: #{index} станция: #{station.name}"
    end
  end

  def trains_list
    @trains.each_with_index do|train, index| 
      puts "В списке с индексом: #{index} поезд №#{train.number}"
    end
  end

  def show_station_train_list
    stations_list
    trains_list
  end

  def to_begin
    loop do
      puts
      puts "Введите номер для: "
      puts "1. Создания станции"
      puts "2. Создания поезда"
      puts "3. Создания маршрута"
      puts "4. Добавления станции"
      puts "5. Удаления станции из маршрута"
      puts "6. Назначения маршрута поезду"
      puts "7. Добавления вагонов к поезду"
      puts "8. Отцепки вагонов от поезда"
      puts "9. Перемещения поезда по маршруту вперед "
      puts "10.Перемещения поезда назад"
      puts "11.Просматривания списка станций и списка поездов на станции"
      puts "12.Вагоны"
      puts "0. Выход"

      input = gets.to_i
      break puts "До свидания!" if input == 0

      case input
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          add_station_route
        when 5
          remove_station
        when 6
          get_route
        when 7
          add_wagon_train
        when 8
          delete_wagon
        when 9
          train_next
        when 10
          train_back
        when 11
          trains_on_station
        when 12
          info_wagons
        end
    end
  end
end


