class CreateTrendings < ActiveRecord::Migration
  def change
    create_table :trendings do |t|
      t.string :instagram_id
      t.string :username
      t.string :full_name
      t.string :profile_image
      t.text :bio
      t.string :uploads
      t.string :followed_by
      t.string :follows
      t.string :website
      t.string :media
      t.string :media_id
      t.string :media_type
      t.timestamps
    end
    add_index :trendings, :instagram_id, :unique => true
    add_index :trendings, :username, :unique => true
  end
end
