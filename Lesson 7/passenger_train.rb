class PassengerTrain < Train
  
  def initialize(number, type = "passenger")
    @number = number
    @type = type
    super
  end

  def add_wagons(wagon)
    if self.type == wagon.type
      super
    else
      puts "К пассажирскому поезду нельзя прицеплять вагоны грузового типа!"
    end
  end

end