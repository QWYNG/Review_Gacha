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
end
