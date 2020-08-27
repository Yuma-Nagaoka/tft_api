require 'net/http'
require 'uri'
require 'json'
require './data_tft'

class Match_list

    @@data_tft = Data_tft.new
    COUNT = 20
    
    def initialize(api_key)
        @api_key = api_key
    end

    def getMatchList
        @@data_tft.getPuuidList.each do |puuid|
            uri = URI.parse("https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/#{puuid["puuid"]}/ids?count=#{COUNT}&api_key=#{@api_key}")
            return_data = Net::HTTP.get(uri)
            matchid = JSON.parse(return_data)
            p matchid
        end       
    end
    
    # def putChallenger_list
    #     hoge = @@data_tft.getSummonerNameList
    #     puts hoge
    # end

end