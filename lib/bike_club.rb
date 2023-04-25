class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.count}
  end

  def best_time(ride)
    @bikers.min_by { |biker| biker.personal_record(ride) }
  end

  def bikers_eligible(ride)
    @bikers.select do |biker|
      biker.max_distance >= ride.distance && biker.acceptable_terrain.include?(ride.terrain)
    end
  end
end