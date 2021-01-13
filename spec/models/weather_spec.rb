require 'rails_helper'

describe Weather, type: :model do
  describe 'relationships' do
    it do
      should have_many :trip_weathers
      should have_many(:trips).through(:trip_weathers)
    end
  end
end
