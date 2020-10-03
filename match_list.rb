require 'net/http'
require 'uri'
require 'json'
require './data_tft'

class Match_list

    @@data_tft = Data_tft.new
    COUNT = 1
    
    def initialize(api_key, game_version)
        @api_key = api_key
        @game_version = game_version
    end
#
    def getMatchidList
        puuid_list = []
        File.open("./data_tft_json/puuid_list.json") do |file|
            puuid_list = JSON.load(file)
        end
        puuid_list.each do |puuid|
            if puuid["tier"] == "demoted" then
                next
            end
            uri = URI.parse("https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/#{puuid["puuid"]}/ids?count=#{COUNT}&api_key=#{@api_key}")
            return_data = Net::HTTP.get(uri)
            status_code = Net::HTTP.get_response(uri).code
            p status_code
            @@data_tft.setMatchidList(JSON.parse(return_data)) if status_code == "200"
            sleep 1
        end
        if @@data_tft.getMatchidList.empty? then
            return 1
        end
        @@data_tft.optimizeMatchidList
        p @@data_tft.getMatchidList
    end
#
    def compareMatchidList
        matchInfoList = []

        if File.exist?("./data_tft_json/match_info_list.json") then
            File.open("./data_tft_json/match_info_list.json") do |file|
                #p "exist"
                matchInfoList = JSON.load(file)
            end
        else
            return 0
        end
        #pp matchInfoList
        matchInfoList.each do |matchInfo|
            p matchInfo.dig("metadata", "match_id")
            if @@data_tft.getMatchidList.include?(matchInfo.dig("metadata", "match_id")) then
                p "This match is already acquired"
                @@data_tft.removeMatchidList(matchInfo.dig("metadata", "match_id"))
            end
        end   
        # if matchInfoList.empty? then
        #     p "match_info_list is empty"
        #     return 0
        # end
        if @@data_tft.getMatchidList.empty? then
            p "New match is not exist"
        else
            p "These are new match.Getting matchInfo"
            p @@data_tft.getMatchidList
        end
        File.open("./data_tft_json/match_info_list.json", "w") do |file|
            file.puts(JSON.pretty_generate(matchInfoList))
        end
    end
#    
    def getMatchInfoList
        #p @@data_tft.getMatchidList
        @@data_tft.getMatchidList.each do |matchid|
            uri = URI.parse("https://asia.api.riotgames.com/tft/match/v1/matches/#{matchid}?api_key=#{@api_key}")
            return_data = Net::HTTP.get(uri)
            status_code = Net::HTTP.get_response(uri).code
            p status_code
            matchInfo = JSON.parse(return_data)
            p "getMatchInfo for ", matchid
            sleep 1 #escape 429Error
            #if matchInfo.dig("info", "game_version") == @game_version then
            @@data_tft.setMatchInfoList(matchInfo) if status_code == "200"
            #end
        end
        #p @@data_tft.getMatchInfoList
    end
#
    def fputMatchInfoList
        matchInfoList = []

        if File.exist?("./data_tft_json/match_info_list.json") then
            File.open("./data_tft_json/match_info_list.json") do |file|
                matchInfoList = JSON.load(file)
            end
        else
            File.open("./data_tft_json/match_info_list.json", "w") do |file|
                file.write("[\n]")
            end
        end
        #pp "before", matchInfoList
        #pp @@data_tft.getMatchInfoList
        matchInfoList.push(@@data_tft.getMatchInfoList)
        matchInfoList.flatten!
        #pp "after", matchInfoList
        File.open("./data_tft_json/match_info_list.json", "w") do |file|
            file.puts(JSON.pretty_generate(matchInfoList))
        end
    end
#
    def getTop4RateList
        puuid_list = []
        matchInfoList = []

        File.open("./data_tft_json/puuid_list.json") do |file|
            puuid_list = JSON.load(file)
        end
        File.open("./data_tft_json/match_info_list.json") do |file|
            matchInfoList = JSON.load(file)
        end
        matchInfoList.each do |matchInfo| #1つの試合ごとの情報
            #p 0
            matchInfo.dig("info", "participants").each do |participant|
                #p 1
                puuid_list.each do |puuid|
                    #p 2
                    if participant["puuid"] == puuid["puuid"] then
                        @@data_tft.setTop4RateList(puuid["name"], puuid["puuid"], matchInfo["metadata"]["match_id"], participant["placement"])
                        #p puuid["name"]
                    end
                end
            end
        end
        #p 3
        @@data_tft.getTop4RateList.each do |a|
            pp a
        end        
    end
#
    def fputTop4RateList       
        top4RateList = @@data_tft.getTop4RateList
        
        # if File.exist?("./data_tft_json/top4_rate_list.json") then
        #     File.open("./data_tft_json/top4_rate_list.json") do |file|
        #         top4RateList = JSON.load(file)
        #     end
        # else
        #     File.open("./data_tft_json/top4_rate_list.json", "w") do |file|
        #         file.write("[\n]")
        #     end
        # end
        # #p top4RateList
        # top4RateList.push(@@data_tft.getTop4RateList)
        # top4RateList.flatten!
        # #pp top4RateList
        File.open("./data_tft_json/top4_rate_list.json", "w") do |file|
            file.puts(JSON.pretty_generate(top4RateList))
        end
    end
    # def putChallenger_list
    #     hoge = @@data_tft.getSummonerNameList
    #     puts hoge
    # end

end