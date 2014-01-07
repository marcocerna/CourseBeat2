class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def create
    @lesson = Lesson.create(params[:lesson])
    params[:categories].each do |text|
      KeyConcept.create(info: text, lesson_id: @lesson.id)
    end

    render json: @lesson, status: 201
  end

  def show

  end

end
