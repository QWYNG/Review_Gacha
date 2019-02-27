require 'sinatra'
require 'json'
require './reviewer_consts/reviewer_consts'
require 'dotenv/load'

def reviewer_gacha
  essntial_reviewer_id = ESSENTIAL_REVIEWERS_IDS.gacha_doesnt_contain(request['user_id'])
  reviewer_id = OTHER_REVIEWERS_IDS.gacha_doesnt_contain(request['user_id'])
  "<@#{essntial_reviewer_id}><@#{reviewer_id}>レビューお願いします"
end

post '/' do
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']

  text = reviewer_gacha

  content_type :json
  {
    title: 'GachaBot',
    text: text
  }.to_json
end

post '/set_reviewer' do
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']

  if request['text'].include("必須")
    ESSENTIAL_REVIEWERS_IDS << request['user_id']
  else
    OTHER_REVIEWERS_IDS << request['user_id']
  end
end
