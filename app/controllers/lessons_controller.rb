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
    @data = {}
    @data["lesson"] = Lesson.find(params[:id])
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
    binding.pry
    @lesson = Lesson.find(params[:id])
    @lesson.update_attributes(params[:lesson])
    render json: @lesson, status: 201
  end

  def destroy
    @lesson = Lesson.destroy(params[:id])
    render json: @lesson, status: 201
  end
end

