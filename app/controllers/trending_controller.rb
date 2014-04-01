class TrendingController < ApplicationController
  def index
    @trending = Trending.order("id DESC").page(params[:page]).per(20)
    expires_in 4.minutes, :public => true    
  end
end
