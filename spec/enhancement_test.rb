require_relative 'spec_helper'

describe Barracks do
  before do
    @barracks = Barracks.new
  end

  context 'when created' do
    it 'should have 500 HP' do
      expect(@barracks.health_points).to eq(500)
    end

    it 'should have 500 lumber' do
      expect(@barracks.lumber).to eq(500)
    end
  end

  context 'when making siege engine' do
    it 'return true for sufficient resources' do
      expect(@barracks.can_train_siege_engine?).to be_truthy
    end

    it 'returns false if there isnt enough food' do
      expect(@barracks).to receive(:food).and_return(2)
      expect(@barracks.can_train_siege_engine?).to be_falsy
    end

    it 'returns false if there isnt enough gold' do
      expect(@barracks).to receive(:gold).and_return(199)
      expect(@barracks.can_train_siege_engine?).to be_falsy
    end

    it 'returns false if there isnt enough lumber' do
      expect(@barracks).to receive(:lumber).and_return(59)
      expect(@barracks.can_train_siege_engine?).to be_falsy
    end

    it 'it creates a siege engine if sufficient resources' do
      expect(@barracks).to receive(:can_train_siege_engine?).and_return(true)
      expect(@barracks.train_siege_engine).to be_a(SiegeEngine)
    end

    it 'it does not create a siege engine if insufficient resources' do
      expect(@barracks).to receive(:can_train_siege_engine?).and_return(false)
      expect(@barracks.train_siege_engine).to be_nil
    end

    it '200 gold is used' do
      @barracks.train_siege_engine
      expect(@barracks.gold).to eq(800)
    end

    it '60 lumber is used' do
      @barracks.train_siege_engine
      expect(@barracks.lumber).to eq(440)
    end

    it '3 food is used' do
      @barracks.train_siege_engine
      expect(@barracks.food).to eq(77)
    end
  end
end

describe SiegeEngine do
  before do
    @siege_engine = SiegeEngine.new
    @enemy_siege_engine = SiegeEngine.new
  end

  context 'when created' do
    it 'should have 50 atk' do
      expect(@siege_engine.attack_power).to eq(50)
    end

    it 'should have 400 HP' do
      expect(@siege_engine.health_points).to eq(400)
    end
  end

  context 'when HP equals 0' do
    it 'should be dead' do
      @siege_engine.damage(@siege_engine.health_points)
      expect(@siege_engine.dead?).to be_truthy
    end

    it 'cannot attack' do
      expect(@siege_engine).to receive(:dead?).and_return(true)
      @siege_engine.attack!(@enemy_siege_engine)
      expect(@enemy_siege_engine.health_points).to eq(400)
    end

    it 'cannot be attacked' do
      expect(@siege_engine).to receive(:dead?).and_return(true)
      expect(@siege_engine.attack!(@siege_engine)).to be_nil
    end
  end

  context 'when HP does not equal 0' do
    it 'should be not dead' do
      @siege_engine.damage(@siege_engine.health_points - 1)
      expect(@siege_engine.dead?).to be_falsy
    end

    it 'can attack siege engines' do
      @siege_engine.attack!(@enemy_siege_engine)
      expect(@enemy_siege_engine.health_points).to eq(350)
    end

    it 'can be attacked by siege engines' do
      expect(@siege_engine).to receive(:dead?).and_return(false)
      @enemy_siege_engine.attack!(@siege_engine)
      expect(@siege_engine.health_points).to eq(350)
    end

    it 'cannot attack footman' do
      footman = Footman.new
      @siege_engine.attack!(footman)
      expect(footman.health_points).to eq(60)
    end

    it 'cannot attack peasant' do
      peasant = Peasant.new
      @siege_engine.attack!(peasant)
      expect(peasant.health_points).to eq(35)
    end

    it 'does double damage on barracks' do
      barracks = Barracks.new
      @siege_engine.attack!(barracks)
      expect(barracks.health_points).to eq(400)
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
