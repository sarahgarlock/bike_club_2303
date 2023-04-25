require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Jamis Crew")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
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

  describe ''
end