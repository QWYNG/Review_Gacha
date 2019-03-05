ENV['APP_ENV'] = 'test'

require './gacha_bot'
require 'rspec'
require 'rack/test'

describe "gacha_bot" do
  let(:reviewer_box) { ReviewerBox.new(essential_reviewers: ['THERESH', 'ALISTAR'], other_reviewrs: ['JANNA', 'MORGANA'])}
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "post / " do
    before do
      post '/'
    end
    
    it 'responce gacha' do
      expect(last_response).to be_ok
    end
  end
  
end
