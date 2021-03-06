require 'rest-client'
require 'multi_json'

module BillyApi
  class Client
    BASE_URL = 'https://api.billysbilling.com/v2/'.freeze

    def self.request(request_method, url, id = nil, payload = {}, &block)
      url = "#{url}/#{id}" if request_method == :get && !id.nil?

      response = RestClient::Request.execute(
        {
          method: request_method,
          url: BASE_URL + url,
          headers: {
            'X-Access-Token' => BillyApi.configuration.api_key,
            'Content-Type' => 'application/json'
          }
        }.merge(request_method == :get ? {} : { payload: MultiJson.dump(payload) })
      )

      if block_given?
        yield MultiJson.load(response.body)
      else
        return MultiJson.load(response.body)
      end
    rescue RuntimeError => e # Todo, find correct exceptions
      puts e.response.body
      # Reraise until better handling, of ResponseObjects are in place.
      raise e
    end
  end
end
