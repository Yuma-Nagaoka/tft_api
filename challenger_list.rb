require 'net/http'
require 'uri'
require 'json'
require './data_tft'

class Challenger_list

    @@data_tft = Data_tft.new
    
    def initialize(api_key)
        @api_key = api_key
    end

    def getChallenger_list
        uri = URI.parse("https://jp1.api.riotgames.com/tft/league/v1/challenger?api_key=#{@api_key}")
        return_data = Net::HTTP.get(uri)
        summoner_data = JSON.parse(return_data)

        summoner_data["entries"].each do |list|
            list.each do |key, value|
                if key == "summonerName" then
                    @@data_tft.setSummonerNameList(value)
                end
            end
        end
    end
    
    def putChallenger_list
        hoge = @@data_tft.getSummonerNameList
        puts hoge
    end

end