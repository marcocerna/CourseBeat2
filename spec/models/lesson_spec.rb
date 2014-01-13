require 'spec_helper'

describe Lesson do

  it "should have a valid factory" do
    FactoryGirl.create(:lesson).should be_valid
  end

  it "should be invalid without a title" do
    FactoryGirl.build(:lesson, title: nil).should_not be_valid
  end

  it { should allow_mass_assignment_of(:title)}
  it { should have_many(:key_concepts) }
end

