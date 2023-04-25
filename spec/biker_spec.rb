require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@biker).to be_a Biker
    end

    it 'has attributes' do
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq 30
    end
  end

  describe '#rides and terrain' do
    it 'starts with no rides and acceptable terrain' do
      expect(@biker.rides).to eq ({})
      expect(@biker.acceptable_terrain).to eq([])
    end

    it "returns the list of acceptable terrains after the biker learns new terrains" do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end
  
  describe "#log ride" do
    it "does not log a ride if the terrain is not in the biker's acceptable terrain" do
      @biker.learn_terrain!(:gravel)
      expect(@biker.log_ride(@ride1, 92.5)).to be_nil
    end
    
    it "does not log a ride if the distance is greater than the biker's max distance" do
      expect(@biker.log_ride(@ride2, 60.9)).to be_nil
    end
    
    it "logs a ride if the terrain is in the biker's acceptable terrain and the distance is within the biker's max distance" do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)
      
      expect(@biker.log_ride(@ride1, 92.5)).to_not be_nil
      expect(@biker.rides).to eq({ @ride1 => [92.5] })
    end
  end
  
  describe "#personal record" do
    it "returns the lowest time recorded for a specific ride" do
      @biker.learn_terrain!(:gravel)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.personal_record(@ride2)).to eq(60.9)
    end
  end
end