class KeyConcept < ActiveRecord::Base
  attr_accessible :info, :lesson_id, :ratingCount, :ratingAverage

  belongs_to :lesson
  has_many :sub_concepts, :dependent => :destroy

  validates :info, presence: true
end
