class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def create
    @lesson = Lesson.create(params[:lesson])

    params[:categories].each do |info, concepts|
      category = KeyConcept.create(info: info, lesson_id: @lesson.id)
      concepts.each do |concept|
        SubConcept.create(info: concept, key_concept_id: category.id)
      end
    end

    render json: @lesson, status: 201
  end

  def show
    @data = {}
    @data["lesson"] = Lesson.find(params[:id])
    categories = KeyConcept.where(lesson_id: @data["lesson"].id)
    concepts = {}

    categories.each do |cat|
      concepts[cat.info] = SubConcept.where(key_concept_id: cat.id)
    end

    @data["categories"] = concepts
    render json: @data, status: 201
  end

end
