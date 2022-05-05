class CargoTrain < Train
  
  def initialize(number, type = "cargo")
    @number = number
    @type = type
    super 
  end

  def add_wagons(wagon)
    if self.type == wagon.type
      super
    else
      puts "К грузовому поезду нельзя прицеплять вагоны пассажирского типа!"
    end
  end

end