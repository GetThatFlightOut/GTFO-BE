require 'rails_helper'

describe Request, type: :model do
  describe 'relationships' do
    it do
      should have_many :request_trips
      should have_many(:trips).through(:request_trips)
    end
  end
end
