class ReviewerBox
  attr_accessor :essential_reviewers, :other_reviewrs

  def initialize(essential_reviewers:, other_reviewrs:)
    @essential_reviewers = essential_reviewers
    @other_reviewrs = other_reviewrs
  end
end
