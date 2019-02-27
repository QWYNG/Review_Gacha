require 'dotenv/load'

ESSENTIAL_REVIEWERS_IDS = ENV['ESSENTIAL_REVIEWERS_IDS'].split(' ')
OTHER_REVIEWERS_IDS = ENV['OTHER_REVIEWERS_IDS'].split(' ')

[ESSENTIAL_REVIEWERS_IDS, OTHER_REVIEWERS_IDS].each do |ids|
  def ids.gacha_doesnt_contain(user_id)
    reject { |id| id == user_id }.sample
  end
end
