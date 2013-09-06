class Category < ActiveRecord::Base
  attr_accessible :description, :name, :image
  @@categories = []
  
  
  def self.get_categories
    @@categories = all if @@categories.blank?

    @@categories
  end
end
