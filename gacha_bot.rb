require 'sinatra'
require 'json'
require './reviewer'
require 'dotenv/load'

reviewer = Reviewer.new([], [])

post '/' do
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']

  essntial_reviewer_id = reviewer.essential_reviwer_gacha_doesnt_include(request['user_id'])
  reviewer_id = reviewer.other_reviwer_gacha_doesnt_include(request['user_id'])
  text = "<@#{essntial_reviewer_id}><@#{reviewer_id}>レビューお願いします"

  content_type :json
  {
    title: 'GachaBot',
    text: text
  }.to_json
end

post '/set' do
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']

  if request['text'].include?('essential')
    reviewer.essential_reviewers << request['user_id']
    text = "SET essntial_reviewer #{request['user_name']}"
  else
    reviewer.other_reviewrs << request['user_id']
    text = "SET reviewer #{request['user_name']}"
  end

  content_type :json
  {
    title: 'GachaBot',
    text: text
  }.to_json
end
