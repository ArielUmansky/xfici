class AddFicinameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fici_name, :string
  end
end
