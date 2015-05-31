class AddDefaults < ActiveRecord::Migration
  def change
    change_column_default :users, :admin, false
    change_column_null :users, :admin, false
    change_column_null :users, :phone, false
    change_column_null :referrals, :created_by, false
  end
end
