class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone
      t.integer :referrals_received

      t.timestamps
    end
  end
end
