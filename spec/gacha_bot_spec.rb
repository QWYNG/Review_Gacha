ENV['APP_ENV'] = 'test'

require './gacha_bot'
require 'rspec'
require 'rack/test'
require './array_extension.rb'

describe "gacha_bot" do
  let!(:reviewer_box) { ReviewerBox.new(essential_reviewers: ['THERESH', 'ALISTAR'], other_reviewrs: ['JANNA', 'MORGANA'])}
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'post / ' do
    before do
      post '/'
    end

    it 'responce ok' do
      expect(last_response).to be_ok
    end
  end

  describe 'post /reviewer' do
    it 'return reviewer json' do
      post '/reviewer'
      expect(last_response).to be_ok
    end
  end
end
