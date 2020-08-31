class Data_tft
    @@summonerNameList = []
    @@summonerInfoList = []
    @@puuidList = []
    @@matchidList = []
    @@matchInfoList = []

    def setSummonerNameList(summonerName)
        @@summonerNameList.push(summonerName)
    end
    def getSummonerNameList()
        return @@summonerNameList
    end

    def setSummonerInfoList(summonerInfo)
        @@summonerInfoList.push(summonerInfo)
    end
    def getSummonerInfoList()
        return @@summonerInfoList
    end

    def setPuuidList(name, puuid)
        puuidHush = {}
        puuidHush.store("name", name)
        puuidHush.store("puuid", puuid)
        @@puuidList.push(puuidHush)
    end
    def getPuuidList()
        return @@puuidList
    end

    def setMatchidList(matchid)
        @@matchidList.push(matchid)
    end
    def getMatchidList()
        return @@matchidList
    end
    def optimizeMatchidList() #配列を平坦化し、重複項目の単一化を実行
        @@matchidList.flatten!.uniq!
    end

    def setMatchInfoList(matchInfo)
        @@matchInfoList.push(matchInfo)
    end
    def getMatchInfoList()
        return @@matchInfoList
    end
    
end
