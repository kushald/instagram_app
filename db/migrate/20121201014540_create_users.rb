class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :instagram_email
      t.string :password
      t.string :auth_token
      t.string :instagram_id
      t.string :instagram_username
      t.string :instagram_access_token
      t.string :instagram_full_name
      t.string :instagram_image

      t.timestamps
    end
  end
end
