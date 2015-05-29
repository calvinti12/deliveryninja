class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.boolean :open

      t.timestamps
    end
  end
end
