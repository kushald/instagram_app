module Request
  def self.get_request(uri)
    uri = URI.parse(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.post_request(params)
    request = HTTParty.post("https://api.instagram.com/oauth/access_token",
                              :body => {
                                        'client_id' => APP_CONFIG['client_id'],
                                        'client_secret' => APP_CONFIG['client_secret'],
                                        'grant_type' => 'authorization_code',
                                        'redirect_uri' => APP_CONFIG['redirect_uri'],
                                        'code' => params[:code]
                                      }
                             )
    JSON.parse(request.body)
  end
end