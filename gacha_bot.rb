require 'sinatra'
require 'json'
require './reviewer'
require 'dotenv/load'

reviewer = Reviewer.new([], [])

def check_token!
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']
end

post '/' do
  check_token!

  user_id = request['user_id']

  essntial_reviewer = reviewer.essential_reviwer_gacha_doesnt_include(user_id)
  reviewer = reviewer.other_reviwer_gacha_doesnt_include(user_id)
  text = "<@#{essntial_reviewer}><@#{reviewer}>レビューお願いします"

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end

post '/set' do
  check_token!

  user_id = request['user_id']

  if request['text'].include?('essential')
    reviewer.essential_reviewers << user_id
    text = "SET essntial_reviewer #{user_id}"
  else
    reviewer.other_reviewrs << user_id
    text = "SET reviewer #{user_id}"
  end

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end

post '/reviewer' do
  check_token!

  text = "essential reviewers\n#{reviewer.format_essential_reviewers}" + "other reviwers\n#{reviewer.format_other_reviewers}"

  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end
