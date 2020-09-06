class Data_tft
    @@summonerNameList = []
    @@summonerInfoList = []
    @@puuidList = []
    @@matchidList = []
    @@matchInfoList = []
    @@top4RateList = []
    # top4RateHash = 
    # {
    #     "summonerName" => "player1",
    #     "puuid" => "abc", 
    #     "matchList" => [
    #         {
    #             "matchid" => "123", 
    #             "placement" => 1 
    #         }
    #     ], 
    #     "top4Rate" => 1 ,
    #     "numberOfMatches" => 1
    # }

        

    def setSummonerNameList(summonerName)
        @@summonerNameList.push(summonerName)
    end
    def getSummonerNameList()
        return @@summonerNameList
    end
#

    def setSummonerInfoList(summonerInfo)
        @@summonerInfoList.push(summonerInfo)
    end
    def getSummonerInfoList()
        return @@summonerInfoList
    end
#

    def setPuuidList(name, puuid)
        puuidHush = {}
        puuidHush.store("name", name)
        puuidHush.store("puuid", puuid)
        @@puuidList.push(puuidHush)
    end
    def getPuuidList()
        return @@puuidList
    end
#

    def setMatchidList(matchid)
        @@matchidList.push(matchid)
    end
    def getMatchidList()
        return @@matchidList
    end
    def optimizeMatchidList() #配列を平坦化し、重複項目の単一化を実行
        @@matchidList.flatten!.uniq!
    end
#

    def setMatchInfoList(matchInfo)
        @@matchInfoList.push(matchInfo)
    end
    def getMatchInfoList()
        return @@matchInfoList
    end
#

    def initTop4RateList(name, puuid)
        top4RateHash = 
        {
            "summonerName" => name,
            "puuid" => puuid, 
            "matchList" => [
                #{
                    #"matchid" => "123", 
                    #"placement" => 1 
                #}
            ], 
            "top4Rate" => 0,
            "numberOfMatches" => 0,
            "top4Matches" => 0
        }
        @@top4RateList.push top4RateHash
    end
    def setTop4RateList(name, puuid, matchid, placement)
        @@top4RateList.each do |summoner|
            if summoner["puuid"] == puuid then
                matchHash = {"matchid" => matchid, "placement" => placement}
                summoner["matchList"].push matchHash
                summoner["numberOfMatches"] += 1
                if placement <= 4 then
                    summoner["top4Matches"] += 1
                end
                summoner["top4Rate"] = summoner["top4Matches"].to_f / summoner["numberOfMatches"]
            end
        end
        @@top4RateList.sort_by! { |a| a["top4Rate"] }.reverse!
    end
    def getTop4RateList()
        return @@top4RateList
    end
#

end
