require 'sinatra'
require 'json'
require './reviewer'
require 'dotenv/load'

reviewer_box = ReviewerBox.new

post '/' do
  check_token!

  user_id = request['user_id']

  essntial_reviewer = reviewer_box.essential_reviwers.sample_except_for(user_id)
  reviewer = reviewer_box.other_reviwer.sample_except_for(user_id)
  text = "<@#{essntial_reviewer}><@#{reviewer}>レビューお願いします"

  response_json(text)
end

post '/set' do
  check_token!

  user_id = request['user_id']

  if request['text'].include?('essential')
    reviewer_box.essential_reviewers << user_id
    text = "SET essntial_reviewer <@#{user_id}>"
  else
    reviewer_box.other_reviewrs << user_id
    text = "SET reviewer <@#{user_id}>"
  end

  response_json(text)
end

post '/reviewer' do
  check_token!

  text = "essential reviewers\n#{reviewer_box.essential_reviwers.format_for_slack}" +
         "reviwers\n#{reviewer_box.other_reviewrs.format_for_slack}"

  response_json(text)
end

post '/remove' do
  check_token!

  user_id = request['user_id']

  if request['text'].include?('reset')
    reviewer_box.essential_reviewers.clear
    reviewer_box.other_reviewrs.clear
    text = 'RESET all reviewers'
  elsif request['text'].include?('essential')
    reviewer_box.essential_reviewers.delete(user_id)
    text = "REMOVE essntial_reviewer <@#{user_id}>"
  else
    reviewer_box.other_reviewrs.delete(user_id)
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
