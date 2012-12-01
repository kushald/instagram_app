class UsersController < ApplicationController
  def likes
    uri = URI.parse("https://api.instagram.com/v1/users/self/media/liked?access_token=#{@current_user.instagram_access_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)
  end

  def following
    uri = URI.parse("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/follows?access_token=#{@current_user.instagram_access_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)["data"]
  end

  def followed_by
    uri = URI.parse("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/followed-by?access_token=#{@current_user.instagram_access_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)["data"]
  end

  def my_pics
    uri = URI.parse("https://api.instagram.com/v1/users/#{@current_user.instagram_id}/media/recent/?access_token=#{@current_user.instagram_access_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    @data = JSON.parse(response.body)["data"]
  end
end
