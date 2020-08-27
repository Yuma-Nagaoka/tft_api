require 'net/http'
require 'uri'
require 'json'

API_KEY = 'RGAPI-30669b9b-e958-43d6-a43d-1e1dd33cc6d2' #　取得したAPI　KEY
name = "Okayu924"
region = "jp"
uri = URI.parse("https://jp1.api.riotgames.com/tft/league/v1/master?api_key=#{API_KEY}")
return_data = Net::HTTP.get(uri)
summoner_data = JSON.parse(return_data)
#summoner_id = summoner_data[name]["id"]

summoner_data["entries"].each do |list|
    list.each do |key, value|
        if key == "summonerName" then
            puts value
        end
    end
end
# {"himrox"=>{"id"=>6180396, "name"=>"himrox", "profileIconId"=>1381, "summonerLevel"=>30, "revisionDate"=>1484446189000}}

#puts summoner_id
# 6180396