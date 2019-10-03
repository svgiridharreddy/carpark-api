class AddColumnsToAvailableCarpark < ActiveRecord::Migration[5.2]
  def change
    add_column :available_carparks, :total_lots, :string
    add_column :available_carparks, :lot_type, :string
    add_column :available_carparks, :lots_available, :string
  end
end
