class SubConcept < ActiveRecord::Base
  attr_accessible :info, :key_concept_id, :ratingCount, :ratingAverage

  belongs_to :key_concept

  validates :info, presence: true
end
