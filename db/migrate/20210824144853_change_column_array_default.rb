class ChangeColumnArrayDefault < ActiveRecord::Migration[6.0]
  def change
   change_column :participations, :role, :string, array: false
   change_column :participations, :state, :string, array: false
   change_column :players, :food_types, :string, array: false
  end
end
