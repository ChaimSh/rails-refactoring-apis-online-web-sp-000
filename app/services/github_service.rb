class GithubService


   attr_reader :access_token 

   
   def initialize(access_hash = nil)
     @access_token = access_hash["access_token"] if access_hash
   end


   def authenticate!(client_id, client_secret, code)
     response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret ,code: code}, {'Accept' => 'application/json'}
     access_hash = JSON.parse(response.body)
     @access_token = access_hash["access_token"]

     user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
     user_json = JSON.parse(user_response.body)
     session[:username] = user_json["login"]
   end




end
