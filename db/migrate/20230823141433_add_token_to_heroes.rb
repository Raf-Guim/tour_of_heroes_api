class AddTokenToHeroes < ActiveRecord::Migration[7.0]
  def change
    add_column :heroes, :token, :string, null: false
    add_index :heroes, :token
  end
end
