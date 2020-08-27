require 'net/http'
require 'uri'
require 'json'
require './data_tft'
require './challenger_list'
require './getPuuid'

API_KEY = 'RGAPI-bc827460-4965-4366-890c-322bde38362e' #　取得したAPI　KEY

class Main
    challenger_list = Challenger_list.new(API_KEY)
    challenger_list.getChallenger_list #チャレンジャーのサモナーネームリストを取得
    challenger_list.putChallenger_list

    getPuuid = GetPuuid.new(API_KEY)
    getPuuid.get_summonerInfo #サモナーネームリストをもとにサモナーの詳細情報を取得
    getPuuid.put_summonerInfo
end
