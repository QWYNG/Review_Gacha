class Reviewer
  attr_accessor :essential_reviewers, :other_reviewrs

  def initialize(essentials, others)
    @essential_reviewers = essentials
    @other_reviewrs = others
  end

  def essential_reviwer_gacha_doesnt_include(person_id)
    @essential_reviewers.reject { |id| id == person_id }.sample
  end

  def other_reviwer_gacha_doesnt_include(person_id)
    @other_reviewrs.reject { |id| id == person_id }.sample
  end

  def format_essential_reviewers
    text = []
    essential_reviewers.each do |essential_reviewer|
      text << "<@#{essential_reviewer}>/n"
    end
    text.inspect
  end

  def format_other_reviewers
    text = []
    other_reviewers.each do |other_reviewer|
      text << "<@#{other_reviewer}>/n"
    end
    text.inspect
  end
end
