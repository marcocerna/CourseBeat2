class Lesson < ActiveRecord::Base
  attr_accessible :title

  has_many :key_concepts, dependent: :destroy

  validates :title, presence: true
end
