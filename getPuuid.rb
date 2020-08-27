require 'net/http'
require 'uri'
require 'json'

class GetPuuid
    @@data_tft = Data_tft.new
    
    def initialize(api_key)
        @api_key = api_key
    end

    def get_summonerInfo
        @@data_tft.getSummonerNameList().each do |summonerName|
            uri = URI.encode("https://jp1.api.riotgames.com/tft/summoner/v1/summoners/by-name/#{summonerName}?api_key=#{@api_key}")
            uri = URI.parse(uri)
            return_data = Net::HTTP.get(uri)
            summoner_info = JSON.parse(return_data)
            @@data_tft.setSummonerInfoList(summoner_info)
        end
    end

    def put_summonerInfo
        puts @@data_tft.getSummonerInfoList
    end

end