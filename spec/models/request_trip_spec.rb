require 'rails_helper'

describe RequestTrip, type: :model do
  describe 'relationships' do
    it do
      should belong_to :trip
      should belong_to :request
    end
  end
end
