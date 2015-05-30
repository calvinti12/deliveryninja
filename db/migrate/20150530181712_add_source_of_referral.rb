class AddSourceOfReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :created_by, :string
    add_column :referrals, :consumed_by, :string
    remove_column :referrals, :used
  end
end
