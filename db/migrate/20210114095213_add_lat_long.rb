class AddLatLong < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :lat, :float
    add_column :weathers, :long, :float
  end
end
