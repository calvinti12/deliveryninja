class Adddefaultadmitted < ActiveRecord::Migration
  def change
    change_column_default :users, :admitted, false
    change_column_null :users, :admitted, false
  end
end
