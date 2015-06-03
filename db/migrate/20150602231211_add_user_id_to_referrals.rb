class AddUserIdToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :user_id, :integer
    remove_column :referrals, :created_by, :string
    remove_column :referrals, :consumed_by, :string
    add_column :referrals, :consumer_id, :integer
    remove_column :users, :admitted, :boolean

    add_index :referrals, :user_id
    add_index :referrals, :consumer_id
  end
end
