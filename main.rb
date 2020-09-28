require 'net/http'
require 'uri'
require 'json'
require './data_tft'
require './challenger_list'
require './puuid_list'
require './match_list'

API_KEY = 'RGAPI-4b9aff1a-c76b-4299-83dc-45af1c7895d7' #　取得したAPI　KEY
GAME_VERSION = "Version 10.19.335.4706 (Sep 10 2020/19:33:20) [PUBLIC] <Releases/10.19>"

class Main
    challenger_list = Challenger_list.new(API_KEY)
    challenger_list.getChallengerList #チャレンジャーのサモナーネームリストを取得
    challenger_list.compareChallengerList
    #challenger_list.putChallengerList

    puuid_list = Puuid_list.new(API_KEY)
    puuid_list.getSummonerInfo #サモナーネームリストをもとにサモナーの詳細情報を取得
    puuid_list.makePuuidList #puuidとサモナーネームのみのリストを作成
    puuid_list.fputPuuidList

    match_list = Match_list.new(API_KEY, GAME_VERSION)
    match_list.getMatchidList #matchidを取得し、リストを作成
    match_list.compareMatchidList
    match_list.getMatchInfoList
    match_list.fputMatchInfoList
    match_list.getTop4RateList
    match_list.fputTop4RateList  
end
