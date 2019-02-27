require 'sinatra'
require 'json'
require './reviewer_consts/reviewer_consts'

post '/' do
  # Might want to add a token read from env variable
  #status 500 unless request['token'] == 'your-token-here'

  text = reviewer_gacha

  content_type :json
  {
    title: 'GachaBot',
    text: text,
  }.to_json

  def reviewer_gacha
    essntial_reviewer_id = ESSENTIAL_REVIEWERS_IDS.gacha_doesnt_contain(data.user)
    reviewer_id = OTHER_REVIEWERS_IDS.gacha_doesnt_contain(data.user)
    "<@#{essntial_reviewer_id}><@#{reviewer_id}>レビューお願いします"
  end
end
