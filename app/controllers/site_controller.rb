class SiteController < ApplicationController
  require 'net/http'
  def index
    uri = URI.parse("https://api.instagram.com/v1/media/popular?client_id=f69d548aeb314c2997583b8cfa154691")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)
  end

  def user
    #    uri = URI.parse("https://api.instagram.com/oauth/access_token")
    #    http = Net::HTTP.new(uri.host, uri.port)
    #    http.use_ssl = true
    #    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #    request = Net::HTTP::Post.new(uri.path)
    #    data = {
    #                      'client_id' => 'f69d548aeb314c2997583b8cfa15469',
    #                      'client_secret' => 'd9bc1e266a914fde80109322f12fd3b3',
    #                      'grant_type' => 'authorization_code',
    #                      'redirect_uri' => 'http://127.0.0.1:3000/user/',
    #                      'code' => params[:code]
    #                    }
    #    request.body = "client_id=f69d548aeb314c2997583b8cfa15469&client_secret=d9bc1e266a914fde80109322f12fd3b3&grant_type=authorization_code&redirect_uri=http://127.0.0.1:3000/user/&code=#{params[:code]}"
    request = HTTParty.post("https://api.instagram.com/oauth/access_token", :body => {:client_id => "d8d1ad02f4564390aaac77be8390c6a6", 'client_secret' => '810f3b8e84354f228effb016b30ad426','grant_type' => 'authorization_code','redirect_uri' => 'http://myinsta.herokuapp.com/user/','code' => params[:code]})
    #request.set_form_data(data, sep = '&')
    response = JSON.parse(request.body)
    @user_info = {
      :full_name => response["user"]["full_name"],
      :id => response["user"]["id"],
      :image => response["user"]["profile_picture"],
      :access_token => response["access_token"]

    }
    uri = URI.parse("https://api.instagram.com/v1/users/#{response["user"]["id"]}/media/recent/?access_token=#{response["access_token"]}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    resp = JSON.parse(response.body)
    @images = []
    @standard_resolution = []
    resp["data"].each do |data|
      @images << data["images"]["low_resolution"]["url"]
      @standard_resolution << data["images"]["standard_resolution"]["url"]
    end
  end

  def user_info
    
    
  end
end
