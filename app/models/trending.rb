class Trending < ActiveRecord::Base
   attr_accessible :instagram_id, :username, :full_name, :profile_image, :bio, :uploads, :followed_by, :follows, :website, :media, :media_id, :media_type
end
