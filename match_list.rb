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
            status_code = Net::HTTP.get_response(uri).code
            p status_code
            matchInfo = JSON.parse(return_data)
            if matchInfo.dig("info", "game_version") == "Version 10.18.333.8889 (Aug 31 2020/10:45:08) [PUBLIC] <Releases/10.18>" then
                @@data_tft.setMatchInfoList(matchInfo)
            end
        end
        #p @@data_tft.getMatchInfoList
    end

    def getTop4RateList
        @@data_tft.getMatchInfoList.each do |matchInfo| #1つの試合ごとの情報
            p 0
            matchInfo.dig("info", "participants").each do |participant|
                p 1
                @@data_tft.getPuuidList.each do |puuid|
                    p 2
                    if participant["puuid"] == puuid["puuid"] then
                        @@data_tft.setTop4RateList(puuid["name"], puuid["puuid"], matchInfo["metadata"]["match_id"], participant["placement"])
                        p puuid["name"]
                    end
                end
            end
        end
        @@data_tft.getTop4RateList.each do |a|
            pp a
        end
            
    end


    # def putChallenger_list
    #     hoge = @@data_tft.getSummonerNameList
    #     puts hoge
    # end

end