class CreateTripWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_weathers do |t|
      t.references :trip, foreign_key: true
      t.references :weather, foreign_key: true

      t.timestamps
    end
  end
end
