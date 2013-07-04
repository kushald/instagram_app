class AddCategoryTypeToInterestingUsers < ActiveRecord::Migration
  def change
    add_column :interesting_users, :category_type, :tinyint, :default => 1
  end
end
