class CategoriesController < ApplicationController
  include SiteHelper
  def index
    @categories = Category.order(:name)
    expires_in 50.minutes, :public => true
    #fresh_when @categories.maximum(:updated_at)
  end

  def show
    @categories = Category.order(:name)
    @category = Category.find(params[:id])
    redirect_to "/categories" if @category.blank?
    @users = InterestingUser.where(:category_type => @category.id).order("instagram_username")
    expires_in 50.minutes, :public => true
    #fresh_when @category
  end
end
