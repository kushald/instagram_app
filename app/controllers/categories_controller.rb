class CategoriesController < ApplicationController
  include SiteHelper
  def index
    @categories = Category.where("id IN (2,3,4,5,6)")
  end

  def show
    @category = Category.find(params[:id])
    redirect_to "/categories" if @category.blank?
    @users = InterestingUser.where(:category_type => @category.id)
  end
end
