class AddTripIdToWeather < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :trip_id, :bigint
  end
end
