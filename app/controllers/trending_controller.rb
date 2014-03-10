class TrendingController < ApplicationController
  def index
    @trending = Trending.page(params[:page]).per(20)
    expires_in 4.minutes, :public => true    
  end
end
