class Data_tft
    @@summonerNameList = []
    @@summonerInfoList = []

    def setSummonerNameList(summonerName)
        @@summonerNameList.push(summonerName)
        return 0
    end
    def getSummonerNameList()
        return @@summonerNameList
    end

    def setSummonerInfoList(summonerInfo)
        @@summonerInfoList.push(summonerInfo)
        return 0
    end
    def getSummonerInfoList()
        return @@summonerInfoList
    end
end
