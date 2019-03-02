require 'sinatra'
require 'json'
require './reviewer'
require 'dotenv/load'

reviewer = Reviewer.new([], [])

def check_token!
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']
end

post '/' do
  p request
  check_token!

  essntial_reviewer = reviewer.essential_reviwer_gacha_doesnt_include(request['user_id'])
  reviewer = reviewer.other_reviwer_gacha_doesnt_include(request['user_id'])
  text = "<@#{essntial_reviewer}><@#{reviewer}>レビューお願いします"

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end

post '/set' do
  check_token!

  if request['text'].include?('essential')
    reviewer.essential_reviewers << request['user_id']
    text = "SET essntial_reviewer #{request['user_name']}"
  else
    reviewer.other_reviewrs << request['user_id']
    text = "SET reviewer #{request['user_name']}"
  end

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end

post '/reviewer' do
  check_token!

  text = reviewer.format_essential_reviewers + reviewer.format_other_reviewers

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end
