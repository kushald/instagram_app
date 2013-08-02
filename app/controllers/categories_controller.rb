class CategoriesController < ApplicationController
  include SiteHelper
  def index
    @categories = Category.where("id IN (2,3,4,5,6)")
    expires_in 50.minutes, :public => true
    #fresh_when @categories.maximum(:updated_at)
  end

  def show
    @category = Category.find(params[:id])
    redirect_to "/categories" if @category.blank?
    @users = InterestingUser.where(:category_type => @category.id).order("instagram_username")
    expires_in 50.minutes, :public => true
    #fresh_when @category
  end
end
