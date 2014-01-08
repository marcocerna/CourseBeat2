class SubConcept < ActiveRecord::Base
  attr_accessible :info, :key_concept_id, :ratingCount, :ratingAverage
  after_initialize :default_values

  belongs_to :key_concept

  validates :info, presence: true

  private

  def default_values
    self.ratingCount    ||= 0
    self.ratingAverage  ||= 0
  end
end
