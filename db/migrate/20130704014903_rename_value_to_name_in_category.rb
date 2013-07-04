class RenameValueToNameInCategory < ActiveRecord::Migration
  def up
    rename_column :categories, :value, :name
  end

  def down
  end
end
