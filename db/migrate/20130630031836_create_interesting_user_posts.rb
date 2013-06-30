class CreateInterestingUserPosts < ActiveRecord::Migration
  def change
    create_table :interesting_user_posts do |t|
      t.string :instagram_user_id
      t.string :media_id
      t.string :image_standard
      t.string :image_low

      t.timestamps
    end
  end
end
