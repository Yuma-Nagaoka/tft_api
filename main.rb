require 'net/http'
require 'uri'
require 'json'
require './data_tft'
require './challenger_list'
require './puuid_list'
require './match_list'

API_KEY = 'RGAPI-f76c7580-9dff-421a-b6c1-8843aebd5002' #　取得したAPI　KEY
GAME_VERSION = "Version 10.20.338.336 (Oct 01 2020/06:14:57) [PUBLIC] <Releases/10.20>"

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
