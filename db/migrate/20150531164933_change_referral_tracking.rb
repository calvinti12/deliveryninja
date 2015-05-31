class ChangeReferralTracking < ActiveRecord::Migration
  def change
    remove_column :users, :referrals_received
    add_column :users, :admitted, :boolean
  end
end
