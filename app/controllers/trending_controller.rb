class TrendingController < ApplicationController
  def index
    @trending = Trending.all
    expires_in 4.minutes, :public => true    
  end
end
