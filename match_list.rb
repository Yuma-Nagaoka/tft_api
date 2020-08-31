require 'net/http'
require 'uri'
require 'json'
require './data_tft'

class Match_list

    @@data_tft = Data_tft.new
    COUNT = 1
    
    def initialize(api_key)
        @api_key = api_key
    end

    def getMatchidList
        @@data_tft.getPuuidList.each do |puuid|
            uri = URI.parse("https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/#{puuid["puuid"]}/ids?count=#{COUNT}&api_key=#{@api_key}")
            return_data = Net::HTTP.get(uri)
            @@data_tft.setMatchidList(JSON.parse(return_data))
        end
        @@data_tft.optimizeMatchidList
        p @@data_tft.getMatchidList       
    end
    
    def getMatchInfoList
        @@data_tft.getMatchidList.each do |matchid|
            uri = URI.parse("https://asia.api.riotgames.com/tft/match/v1/matches/#{matchid}?api_key=#{@api_key}")
            return_data = Net::HTTP.get(uri)
            matchInfo = JSON.parse(return_data)
            if matchInfo.dig("info", "game_version") == "Version 10.16.330.9186 (Jul 31 2020/17:29:29) [PUBLIC] <Releases/10.16>" then
                @@data_tft.setMatchInfoList(matchInfo)
            end

        end
        p @@data_tft.getMatchInfoList
    end

    # def putChallenger_list
    #     hoge = @@data_tft.getSummonerNameList
    #     puts hoge
    # end

end