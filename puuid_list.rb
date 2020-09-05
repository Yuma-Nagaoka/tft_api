require 'net/http'
require 'uri'
require 'json'

class Puuid_list

    @@data_tft = Data_tft.new
    
    def initialize(api_key)
        @api_key = api_key
    end

    def getSummonerInfo
        @@data_tft.getSummonerNameList().each do |summonerName|
            uri = URI.encode("https://jp1.api.riotgames.com/tft/summoner/v1/summoners/by-name/#{summonerName}?api_key=#{@api_key}")
            uri = URI.parse(uri)
            return_data = Net::HTTP.get(uri)
            summoner_info = JSON.parse(return_data)
            @@data_tft.setSummonerInfoList(summoner_info)
        end
    end

    def putSummonerInfo
        puts @@data_tft.getSummonerInfoList
    end

    def makePuuidList
        @@data_tft.getSummonerInfoList.each do |summonerInfo|
            if summonerInfo["name"] != nil then
                @@data_tft.setPuuidList(summonerInfo["name"], summonerInfo["puuid"])
                @@data_tft.initTop4RateList(summonerInfo["name"], summonerInfo["puuid"])
            # elsif summonerInfo["status"]["status_code"] == 429 then
            #     p "Rate limit exceed"
            else 
                p "Error occurred in getting every summoner infomation. Error details are as shown below", summonerInfo 
            end
        end
    end

    def putPuuidList
        puts @@data_tft.getPuuidList
    end

end