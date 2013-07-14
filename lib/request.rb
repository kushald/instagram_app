module Request
  def self.get_request(url)
    JSON.parse((HTTParty.get(URI.encode(url.strip).to_s)).body)
  end

  def self.post_request(params)
    JSON.parse((HTTParty.post(params[:uri], :body => self.post_request_body(params))).body)
  end

  def self.http_client_get(url)
    JSON.parse(HTTPClient.new.get(URI.encode(url.strip).to_s).body)
  end

  private

  #----------------
  def self.get_url(p)
    path =  case p[:t]
              when :pop
                "media/popular"
              when :m
                "media/#{p[:id]}"
              when :ud
                "users/#{p[:mid]}/media/recent/"
              when :rel
                "users/#{p[:mid]}/relationship"    
            end 
      Constant::ENDPOINT+path+"?access_token=#{p[:at]}"
  end

  def self.post_request_body(params)
    if params[:type] == 'access_token'
      {
        'client_id' => APP_CONFIG['client_id'],
        'client_secret' => APP_CONFIG['client_secret'],
        'grant_type' => 'authorization_code',
        'redirect_uri' => APP_CONFIG['redirect_uri'],
        'code' => params[:code]
      }
    elsif params[:type] == 'relationship'
      {
        'access_token' => params[:access_token],
        'action' => params[:action]
      }
    else
      {
        'text' => params[:text],
        'access_token' => params[:access_token]
      }
    end
  end
end