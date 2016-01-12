require_relative 'spec_helper'

describe Barracks do
  before do
    @barracks = Barracks.new
  end

  context 'when created' do
    it 'should have 500 HP' do
      expect(@barracks.health_points).to eq(500)
    end
  end



end


describe Footman do
  before do
    @footman = Footman.new
    @enemy_footman = Footman.new
  end

  context 'when HP equals 0' do
    it 'should be dead' do
      @footman.damage(@footman.health_points)
      expect(@footman.dead?).to be_truthy
    end

    it 'cannot attack' do
      expect(@footman).to receive(:dead?).and_return(true)
      @footman.attack!(@enemy_footman)
      expect(@enemy_footman.health_points).to eq(60)
    end

    it 'cannot be attacked' do
      expect(@footman).to receive(:dead?).and_return(true)
      expect(@enemy_footman.attack!(@footman)).to be_nil
    end
  end

  context 'when HP does not equal 0' do
    it 'should be not dead' do
      @footman.damage(@footman.health_points - 1)
      expect(@footman.dead?).to be_falsy
    end

    it 'can attack' do
      @footman.attack!(@enemy_footman)
      expect(@enemy_footman.health_points).to eq(50)
    end

    it 'can be attacked' do
      expect(@footman).to receive(:dead?).and_return(false)
      @enemy_footman.attack!(@footman)
      expect(@footman.health_points).to eq(50)
    end
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
