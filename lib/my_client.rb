require 'httparty'
require 'digest'

class MyClient

  include HTTParty

  base_uri Rails.application.secrets.uri
  default_timeout 1


  def initialize(params = {})
    @env = params[:env].blank? ? 'prod' : params[:env]
    @base_path = base_path
    @key = api_key
    @redis = Redis.new
  end

  def handle_timeouts
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      puts 'Timeout bro'
    end
  end


  def handle_caching(url)
    key = cache_key(url)
    if cached = @redis.get(key)
      JSON[cached]
    else
      yield.tap do |results|
        # @redis.set(key, results.to_json) dla trwalego cache do restartu serwera
        @redis.setex(key, 3600, results.to_json)
      end
    end
  end


  def cache_key(url)
    "my_client:#{url}:#{Digest::SHA256.hexdigest(url)}"
  end

  def base_url
    Rails.application.secrets.uri
  end

  def api_key
    Rails.application.secrets.my_token
  end

  def headers
    { :headers => {"Authorization" => "Token token=#{api_key}" } }
  end

  def base_path
    @env == 'prod' ? '/api' : '/api_test'
  end

  def projects

    url = "#{ base_path }/projects.json"
    handle_timeouts do
      handle_caching(url) do
    self.class.get( url, headers )
    end
  end
end
  def project(project_id)
    url = "#{ base_path }/projects/#{project_id}.json"
    handle_timeouts do
      self.class.get( url, headers )
    end
  end
  def new_project(options)
    url = "#{base_path}/projects.json"
    query = { :body => { :project => options } }.merge (headers)
    self.class.post(url, query)
  end

  def edit_project(project_id, options)
    url = "#{base_path}/projects/#{project_id}.json"
    # options = { name: "Edited by API" }
    query = { :body => {:project => options } }.merge(headers)
    self.class.put(url, query)
  end

  def delete_project(project_id)
    url = "#{base_path}/projects/#{project_id}.json"
    self.class.delete(url, headers)
  end

end