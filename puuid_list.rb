require 'net/http'
require 'uri'
require 'json'
require 'cgi'

class Puuid_list

    @@data_tft = Data_tft.new
    
    def initialize(api_key)
        @api_key = api_key
    end
#
    def getSummonerInfo
        @@data_tft.getSummonerNameList().each do |summonerName|
            summonerName_escape = CGI.escape(summonerName)
            uri = URI.parse("https://jp1.api.riotgames.com/tft/summoner/v1/summoners/by-name/#{summonerName_escape}?api_key=#{@api_key}")
            #p uri
            return_data = Net::HTTP.get(uri)
            summoner_info = JSON.parse(return_data)
            @@data_tft.setSummonerInfoList(summoner_info)
            #p "getSummonerInfo for ", summonerName
            #sleep 1 #escape 429Error
        end
    end
#
    def putSummonerInfo
        puts @@data_tft.getSummonerInfoList
    end
#
    def makePuuidList
        @@data_tft.getSummonerInfoList.each do |summonerInfo|
            if summonerInfo["name"] != nil then
                @@data_tft.setPuuidList(summonerInfo["name"], summonerInfo["puuid"])
            else 
                p "Error occurred in getting every summoner infomation. Error details are as shown below", summonerInfo 
            end
        end
    end
#
    def putPuuidList
        puts @@data_tft.getPuuidList
    end
#
    def fputPuuidList       #new faceのpuuidを取得し、jsonファイルを更新する
        puuidList = []

        if File.exist?("./data_tft_json/puuid_list.json") then
            File.open("./data_tft_json/puuid_list.json") do |file|
                puuidList = JSON.load(file)
            end
        else
            File.open("./data_tft_json/puuid_list.json", "w+") do |file|
                file.write("[\n]")
            end
        end
        #p puuidList
        puuidList.push(@@data_tft.getPuuidList)
        puuidList.flatten!
        #p puuidList
        puuidList.each do |puuid|
            next if puuid["tier"] == "demoted"
            @@data_tft.initTop4RateList(puuid["name"], puuid["puuid"])
        end
        File.open("./data_tft_json/puuid_list.json", "w") do |file|
            file.puts(JSON.pretty_generate(puuidList))
        end
    end

end