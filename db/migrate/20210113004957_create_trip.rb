class CreateTrip < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :origin_city
      t.string :destination_city
      t.string :origin_iata
      t.string :destination_iata
      t.float :latitude
      t.float :longitude
      t.integer :price
      t.datetime :departure_datetime
      t.datetime :arrival_datetime
      t.datetime :r_departure_datetime
      t.datetime :r_arrival_datetime
      t.string :booking_link
      t.integer :trip_duration
      t.integer :flight_id

      t.references :weather

      t.timestamps
    end
  end
end
