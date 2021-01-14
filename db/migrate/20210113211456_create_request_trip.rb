class CreateRequestTrip < ActiveRecord::Migration[5.2]
  def change
    create_table :request_trips do |t|
      t.references :trip, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
