class Data_tft
    @@summonerNameList = []
    @@summonerInfoList = []
    @@puuidList = []

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

end
