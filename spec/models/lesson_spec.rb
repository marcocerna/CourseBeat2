require 'spec_helper'

describe Lesson do
  before :each do
    @lesson = Lesson.new
  end

  it {should validate_presence_of(:title)}


end

