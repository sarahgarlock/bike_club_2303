class Biker
  attr_reader :name, 
              :max_distance, 
              :acceptable_terrain, 
              :rides

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @acceptable_terrain = []
    @rides = {}
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain unless @acceptable_terrain.include?(terrain)
  end

  def log_ride(ride, time)
    return unless @acceptable_terrain.include?(ride.terrain) && ride.distance <= @max_distance

    @rides[ride] ||= []
    @rides[ride] << time
  end

  def personal_record(ride)
    return false unless @rides.key?(ride)

    @rides[ride].min
  end
end