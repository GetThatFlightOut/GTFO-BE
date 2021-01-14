class RemoveTripIdFromWeather < ActiveRecord::Migration[5.2]
  def change
    remove_column :weathers, :trip_id
  end
end
