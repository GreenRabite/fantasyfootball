require 'oauth_util.rb'
require 'net/http'

o = OauthUtil.new

o.consumer_key = 'examplek9SGJUTUpocjZ5QjBJmQ9WVdrOVVFNHdSR2x1TkhFbWNHbzlNQS0tJnM9Y29uc3VtkZXJzZWNyZXQmeD0yYg--';
o.consumer_secret = 'exampled88d4109c63e778dsadcdd5c1875814977';

url = 'http://query.yahooapis.com/v1/yql?q=select%20*%20from%20social.updates.search%20where%20query%3D%22search%20terms%22&diagnostics=true';

parsed_url = URI.parse( url )

Net::HTTP.start( parsed_url.host ) { | http |
  req = Net::HTTP::Get.new "#{ parsed_url.path }?#{ o.sign(parsed_url).query_string }"
  response = http.request(req)
  print response.read_body
}
