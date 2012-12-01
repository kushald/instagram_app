class SiteController < ApplicationController
  require 'net/http'
  def index
    uri = URI.parse("https://api.instagram.com/v1/media/popular?client_id=d8d1ad02f4564390aaac77be8390c6a6")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)
  end

  def user
    if @current_user.blank?
      request = HTTParty.post("https://api.instagram.com/oauth/access_token",
                              :body => {
                                        'client_id' => "d8d1ad02f4564390aaac77be8390c6a6",
                                        'client_secret' => '810f3b8e84354f228effb016b30ad426',
                                        'grant_type' => 'authorization_code',
                                        'redirect_uri' => 'http://myinsta.herokuapp.com/user/',
                                        'code' => params[:code]
                                      }
                             )
      response = JSON.parse(request.body)

        User.authenticate(
                          :insta_id => response["user"]["id"],
                          :access_token => response["access_token"],
                          :username => response["user"]["username"],
                          :full_name => response["user"]["full_name"],
                          :instagram_image => response["user"]["image"]
                         )

        cookies["ac"] = {:value => Array.new(10).map { (65 + rand(58)) }.join + "a#{@current_user.id}", :expires => Time.now+365.day}
    end
    uri = URI.parse("https://api.instagram.com/v1/users/self/feed?access_token=#{@current_user.instagram_access_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)
  end

  def user_info
    
    
  end
end
