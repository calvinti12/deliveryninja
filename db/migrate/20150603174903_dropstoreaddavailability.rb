class Dropstoreaddavailability < ActiveRecord::Migration
  def change
    drop_table :stores
    add_column :users, :available, :boolean
    change_column_default :users, :available, true
  end
end
