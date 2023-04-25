require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Jamis Crew")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @biker3 = Biker.new("Sarah", 33)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

  end

  describe '#initialize' do
    it 'exists' do
      expect(@bike_club).to be_a BikeClub
    end

    it 'has attributes' do
      expect(@bike_club.name).to eq("Jamis Crew")
    end
  end

  describe '#bikers' do 
    it 'returns an empty array of Bikers to start' do
      expect(@bike_club.bikers).to eq([])
    end

    it 'can add Bikers' do
      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      expect(@bike_club.bikers).to contain_exactly(@biker1, @biker2)
    end
  end

  describe '#most rides' do
    it 'can return the Biker with the most rides' do
      @biker1.learn_terrain!(:gravel)
      @biker1.learn_terrain!(:hills)
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      @biker1.log_ride(@ride1, 92.5)
      @biker2.log_ride(@ride1, 60.9)
      @biker2.log_ride(@ride2, 61.6)

      expect(@bike_club.most_rides).to eq(@biker2)
    end
  end

  describe '#best time' do
    it 'can return the Biker with the best time' do
      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)
      
      @biker1.learn_terrain!(:gravel)
      @biker1.learn_terrain!(:hills)
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)

      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride2, 64.6)
      @biker2.log_ride(@ride1, 60.9)
      @biker2.log_ride(@ride2, 65.6)

      expect(@bike_club.best_time(@ride1)).to eq(@biker2)
      expect(@bike_club.best_time(@ride2)).to eq(@biker1)
    end
  end

  describe '#eligible' do
    it 'can tell us which Biker is eligible for a given ride' do
      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)
      @bike_club.add_biker(@biker3)

      @biker1.learn_terrain!(:hills)
      @biker2.learn_terrain!(:gravel)
      @biker2.learn_terrain!(:hills)
      @biker3.learn_terrain!(:gravel)

      @biker1.log_ride(@ride1, 92.5)
      @biker2.log_ride(@ride1, 60.9)
      @biker2.log_ride(@ride2, 65.6)
      @biker3.log_ride(@ride2, 62.4)

      expect(@bike_club.bikers_eligible(@ride1)).to eq([@biker1, @biker2])
      expect(@bike_club.bikers_eligible(@ride2)).to eq([@biker2, @biker3])
    end
  end
end