require 'array_extension.rb'

class ReviewerBox
  attr_accessor :essential_reviewers, :other_reviewrs

  using ArrayExtension

  def initialize(essential_reviewers = [], other_reviewrs = [])
    @essential_reviewers = essential_reviewers
    @other_reviewrs = other_reviewrs
  end
end
