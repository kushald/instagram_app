module Request
  def self.get_request(uri)
    JSON.parse((HTTParty.get(uri)).body)
  end

  def self.post_request(params)
    JSON.parse((HTTParty.post("https://api.instagram.com/oauth/access_token",
                              :body => {
                                        'client_id' => APP_CONFIG['client_id'],
                                        'client_secret' => APP_CONFIG['client_secret'],
                                        'grant_type' => 'authorization_code',
                                        'redirect_uri' => APP_CONFIG['redirect_uri'],
                                        'code' => params[:code]
                                      }
                             )).body)
  end
end