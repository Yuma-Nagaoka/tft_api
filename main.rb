require 'net/http'
require 'uri'
require 'json'
require './data_tft'
require './challenger_list'
require './puuid_list'
require './match_list'

API_KEY = 'RGAPI-d69657f0-900e-407f-a25b-be016c278971' #　取得したAPI　KEY

class Main
    challenger_list = Challenger_list.new(API_KEY)
    challenger_list.getChallenger_list #チャレンジャーのサモナーネームリストを取得
    #challenger_list.putChallenger_list

    puuid_list = Puuid_list.new(API_KEY)
    puuid_list.getSummonerInfo #サモナーネームリストをもとにサモナーの詳細情報を取得
    puuid_list.makePuuidList #puuidとサモナーネームのみのリストを作成
    puuid_list.putPuuidList

    match_list = Match_list.new(API_KEY)
    match_list.getMatchidList #matchidを取得し、リストを作成
    match_list.getMatchInfoList
    match_list.getTop4RateList
end
