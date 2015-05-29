class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :code
      t.boolean :used

      t.timestamps
    end
  end
end
