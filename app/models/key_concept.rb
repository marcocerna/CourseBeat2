class KeyConcept < ActiveRecord::Base
  attr_accessible :info, :lesson_id, :ratingCount, :ratingAverage
  after_initialize :default_values

  belongs_to :lesson
  has_many :sub_concepts, :dependent => :destroy

  validates :info, presence: true

  private

    def default_values
      self.ratingCount    ||= 0
      self.ratingAverage  ||= 0
    end
end
