class CreateCarparkInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :carpark_infos do |t|
      t.string :carpark_no
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :carpark_type
      t.string :parking_system_type
      t.string :short_term_parking
      t.string :free_parking
      t.boolean :night_parking
      t.integer :carpark_decks
      t.float :grantry_height
      t.boolean :basement_parking

      t.timestamps
    end
  end
end
