require 'net/http'
require 'uri'
require 'json'
require './data_tft'

class Challenger_list

    @@data_tft = Data_tft.new
    
    def initialize(api_key)
        @api_key = api_key
    end

    def getChallengerList
        p "challenger list"
        uri = URI.parse("https://jp1.api.riotgames.com/tft/league/v1/challenger?api_key=#{@api_key}")
        #p uri
        return_data = Net::HTTP.get(uri)
        summoner_data = JSON.parse(return_data)

        summoner_data["entries"].each do |list|
            list.each do |key, value|
                if key == "summonerName" then
                    @@data_tft.setSummonerNameList(value)
                end
            end
        end
        p @@data_tft.getSummonerNameList
    end
    
    def compareChallengerList #マスター落ちしたサモナーはpuuid["tier"]="demoted"とする
        puuidList = []
        
        if File.exist?("./data_tft_json/puuid_list.json") then
            File.open("./data_tft_json/puuid_list.json") do |file|
                puuidList = JSON.load(file)
            end
        else
            return 0
        end
        #pp puuidList
        puuidList.each do |puuid|
            if @@data_tft.getSummonerNameList.include?(puuid["name"]) then
                @@data_tft.removeSummonerNameList(puuid["name"])
                puuid["tier"] = "challenger"
            else 
                p "The summoner is demoted ", puuid["name"]
                puuid["tier"] = "demoted"
            end
        end   
        # if puuidList.empty? then
        #     p "puuid_list is empty"
        #     return 0
        # end
        if @@data_tft.getSummonerNameList.empty? then
            p "Nobody is new face"
        else
            p "They are new face.Getting their puuid"
            p @@data_tft.getSummonerNameList
        end
        File.open("./data_tft_json/puuid_list.json", "w") do |file|
            file.puts(JSON.pretty_generate(puuidList)) 
        end
        #p @@data_tft.getSummonerNameList
    end

    # def putChallengerList
    #     p @@data_tft.getSummonerNameList
    # end

end