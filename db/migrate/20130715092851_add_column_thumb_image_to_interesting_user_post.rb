class AddColumnThumbImageToInterestingUserPost < ActiveRecord::Migration
  def change
    add_column :interesting_user_posts, :thumb_image, :string
  end
end
