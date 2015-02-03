class FixPostNameInComments < ActiveRecord::Migration
  def change
  	rename_column :comments, :post_id, :micropost_id
  end
end
