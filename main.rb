require 'net/http'
require 'uri'
require 'json'
require './data_tft'
require './challenger_list'
require './puuid_list'
require './match_list'

API_KEY = 'RGAPI-335109ef-1418-4195-9da9-11f842c5abce' #　取得したAPI　KEY

class Main
    challenger_list = Challenger_list.new(API_KEY)
    challenger_list.getChallenger_list #チャレンジャーのサモナーネームリストを取得
    #challenger_list.putChallenger_list

    puuid_list = Puuid_list.new(API_KEY)
    puuid_list.getSummonerInfo #サモナーネームリストをもとにサモナーの詳細情報を取得
    puuid_list.makePuuidList #puuidとサモナーネームのみのリストを作成
    puuid_list.putPuuidList

    match_list = Match_list.new(API_KEY)
    match_list.getMatchList
end
