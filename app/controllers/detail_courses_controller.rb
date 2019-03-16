class DetailCoursesController < ApplicationController
  before_action :set_detail_course, only: [:show, :update, :destroy]

  # GET /detail_courses
  def index
    @detail_courses = DetailCourse.all

    render json: @detail_courses
  end

  # GET /detail_courses/1
  def show
    render json: @detail_course
  end

  # POST /detail_courses
  def create
    @detail_course = DetailCourse.new(detail_course_params)

    if @detail_course.save
      render json: @detail_course, status: :created, location: @detail_course
    else
      render json: @detail_course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /detail_courses/1
  def update
    if @detail_course.update(detail_course_params)
      render json: @detail_course
    else
      render json: @detail_course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /detail_courses/1
  def destroy
    @detail_course.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail_course
      @detail_course = DetailCourse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def detail_course_params
      params.require(:detail_course).permit(:user_id, :course_id)
    end
end
