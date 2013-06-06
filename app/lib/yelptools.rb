module Yelptools
  def self.search

    client = Yelp::Client.new

    request = Yelp::V2::Business::Request::Id.new(
      :yelp_business_id => "kIW31DO7Zkt9TPnSG1Qdug",
      :consumer_key => 'CONSUMER_KEY',
      :consumer_secret => 'CONSUMER_SECRET',
      :token => 'TOKEN',
      :token_secret => 'TOKEN_SECRET')
    response = client.search(request)

    return response
  end
end