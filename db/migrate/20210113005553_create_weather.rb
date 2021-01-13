class CreateWeather < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.float :min_f
      t.float :max_f
      t.float :min_c
      t.float :max_c
      t.float :day_feels_like_c
      t.float :day_feels_like_f
      t.string :description
      t.datetime :date
      t.integer :sky_coverage

      t.timestamps
    end
  end
end
