class CreateInterestingUsers < ActiveRecord::Migration
  def change
    create_table :interesting_users do |t|
      t.string :instagram_user_id
      t.string :instagram_profile_picture
      t.string :instagram_username
      t.timestamps
    end
  end
end
