require 'spec_helper'

describe LessonsController do

  describe "GET index" do
    it "should assign @lessons" do
      lesson = Lesson.create(title: "Test lesson")
      get :index
      assigns(:lessons).should == [lesson]
    end

    it "should render index.html.erb" do
      get :index
      response.should render_template :index
    end

  end

  describe "POST create" do

    context "with valid attributes" do
      it "should assign new Lesson to database"
      it "should assign new KeyConcept for each element in categories"
      it "should assign new SubConcept for each element in concepts"
      it "should render @lesson as json"
    end

    context "with invalid attributes" do
      it "should not assign new Lesson to database"
    end

  end

  describe "GET show" do
    it "should create an empty @data hash"
    it "should have a params[:id]"
    it "should set data.lesson with appropriate Lesson"
    it "should grab KeyConcepts with data.lesson.id and set them in categories"
    it "should create an empty concepts hash"
    it "should grab SubConcepts for each KeyConcept and link them in concepts hash"
    it "should set data.categories with concepts hash"
    it "should render @data as json"
  end

  describe "POST vote" do

  end

end