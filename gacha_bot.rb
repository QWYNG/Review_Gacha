require 'sinatra'
require 'json'
require './reviewer'
require 'dotenv/load'

reviewer = Reviewer.new

post '/' do
  check_token!

  user_id = request['user_id']

  essntial_reviewer = reviewer.essential_reviwer_gacha_doesnt_include(user_id)
  reviewer = reviewer.other_reviwer_gacha_doesnt_include(user_id)
  text = "<@#{essntial_reviewer}><@#{reviewer}>レビューお願いします"

  response_json(text)
end

post '/set' do
  check_token!

  user_id = request['user_id']

  if request['text'].include?('essential')
    reviewer.essential_reviewers << user_id
    text = "SET essntial_reviewer <@#{user_id}>"
  else
    reviewer.other_reviewrs << user_id
    text = "SET reviewer <@#{user_id}>"
  end

  response_json(text)
end

post '/reviewer' do
  check_token!

  text = "essential reviewers\n#{reviewer.format_essential_reviewers}" + "reviwers\n#{reviewer.format_other_reviewers}"

  response_json(text)
end

post '/remove' do
  check_token!

  user_id = request['user_id']

  if request['text'].include?('reset')
    reviewer.essential_reviewers.clear
    reviewer.other_reviewrs.clear
  elsif request['text'].include?('essential')
    reviewer.essential_reviewers.delete(user_id)
    text = "REMOVE essntial_reviewer <@#{user_id}>"
  else
    reviewer.other_reviewrs.delete(user_id)
    text = "REMOVE reviewer <@#{user_id}>"
  end

  response_json(text)
end

private

def check_token!
  status 500 if request['token'] != ENV['VERIFICATION_TOKEN']
end

def response_json(text)
  content_type :json
  {
    response_type: 'in_channel',
    text: text
  }.to_json
end
