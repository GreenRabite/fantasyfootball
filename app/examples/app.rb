require 'oauth_util.rb'
require 'net/http'

def get_response(args,buckets)
    url = "https://yboss.yahooapis.com/ysearch/"+buckets+"?"
    arg_count = 0
    args.each do|key,value|
        url = url + key + "=" + value+"&"
        ++arg_count
    end

    if(arg_count > 0) 
        url.slice!(url.length-1)
    end 

    parsed_url = URI.parse( url )

    o = OauthUtil.new
    o.consumer_key = "<em><strong>ADD YOUR KEY HERE</strong></em>"
    o.consumer_secret = "<strong>ADD YOUR SECRET HERE</strong>"

    Net::HTTP.start( parsed_url.host ) { | http |
        req = Net::HTTP::Get.new "#{ parsed_url.path }?#{ o.sign(parsed_url).query_string }"
        response = http.request(req)
        return response.read_body
    }
end

args = Hash.new
args["format"] = "xml"
#args["format"] = "json"
args["q"] = "watch1"
args["count"] = "1"

buckets = "web"

print get_response(args,buckets)