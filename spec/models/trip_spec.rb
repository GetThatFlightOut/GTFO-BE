require 'rails_helper'

describe Trip, type: :model do
  describe 'relationships' do
    it do
      should have_many :trip_weathers
      should have_many(:weathers).through(:trip_weathers)
      should have_many :request_trips
      should have_many(:requests).through(:request_trips)
    end
  end
end
