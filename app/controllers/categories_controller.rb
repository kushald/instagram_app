class CategoriesController < ApplicationController
  include SiteHelper
  def index
    @interesting_users = InterestingUser.where(:category_type => 2).order("instagram_username").all
  end
end
