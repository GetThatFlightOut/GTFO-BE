class CreateRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :uid

      t.timestamps
    end
  end
end
