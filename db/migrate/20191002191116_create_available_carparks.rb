class CreateAvailableCarparks < ActiveRecord::Migration[5.2]
  def change
    create_table :available_carparks do |t|
      t.string :carpark_no
      t.string :update_datetime
      t.text :carpark_info

      t.timestamps
    end
  end
end
