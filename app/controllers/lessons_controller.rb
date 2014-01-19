class LessonsController < ApplicationController
  include LessonsHelper

  def index
    @lessons = Lesson.order(:id) # Otherwise updates will reorder them
  end

  def create
    # Refactor: silent error when category has no concepts
    @lesson = Lesson.create(params[:lesson])
    create_categories if params[:categories]
    render json: @lesson, status: 201
  end

  def show
    get_concepts
    render json: @data, status: 201
  end

  def vote
    @concept = SubConcept.find(params[:id])
    @concept.update_attributes(ratingCount: @concept.ratingCount + 1)
    @concept.update_attributes(ratingAverage: calculate_rating)
    render json: @concept, status: 201
  end

  def update
    lesson = Lesson.find(params[:id])
    @data = {"lesson" => lesson.update_attributes(params[:lesson]) }

    params[:categories].each do |k, cat|
      # Refactor: when new Category is created (probably an if id = nil or something like that)
      category = KeyConcept.find(cat["id"])
      category.update_attributes(info: cat["info"])
    end
    params[:concepts].each do |k, con|
      # Refactor: same as above
      concept = SubConcept.find(con["id"])
      concept.update_attributes(info: con["info"])
    end

    get_concepts

    render json: @data, status: 201
  end

  def destroy
    @lesson = Lesson.destroy(params[:id])
    render json: @lesson, status: 201
  end
end

