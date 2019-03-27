class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.all

    render json: @courses
  end

  # GET /courses/1
  def show
    render json: { id: @course.id,
                   name: @course.user.username,
                   price: @course.price,
                   uptime: @course.uptime,
                   skill: @course.skill,
                   description: @course.description,
                   student_list: get_student_list(@course),
                   amount_student: @course.detail_courses.count,
                   class_opened: @course.user.courses.count
    }
  end

  def get_student_list course
    student_list = course.detail_courses.pluck(:user_id)
    return User.where(id: student_list).pluck(:username)
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.includes(:detail_courses, :user).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:user_id, :price, :uptime, :skill, :district, :city, :address, :description)
    end
end
