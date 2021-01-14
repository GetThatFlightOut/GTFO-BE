class AddRequestData < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :departure_airport, :string
    add_column :requests, :departure_date, :string
    add_column :requests, :trip_duration, :string
    add_column :requests, :limit, :string
  end
end
