require_relative 'spec_helper'

describe Barracks do
  before do
    @barracks = Barracks.new
  end

  it 'should have 500 HP' do
    expect(@barracks.health_points).to eq(500)
  end
end


describe Footman do
  before do
    @footman = Footman.new
  end

  context 'when attacking barracks' do
    before do
      @barracks = Barracks.new
    end
    it 'should do half the damage' do
      expect(@barracks).to receive(:damage).with(5)
      @footman.attack!(@barracks)
    end 
  end
end
