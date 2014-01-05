class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def new

  end

  def create
    @lesson = Lesson.create(params[:lesson])
    render json: @lesson, status: 201
  end

  def show

  end

end
