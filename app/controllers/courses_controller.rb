class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create]

  # GET /courses
  def index
    @courses = Course.all.order(created_at: :desc)

    render json: @courses.as_json(only: Course::JSON_AGUMENT, include: [{user: {only: [:id, :username, :profile_image]}}])
  end

  # GET /courses/1
  def show
    render json: {
      id: @course.id,
      name: @course.user.username,
      price: @course.price,
      uptime: @course.uptime,
      skill: @course.skill,
      description: @course.description,
      student_list: get_student_list(@course),
      amount_student: @course.detail_courses.count,
      class_opened: @course.user.courses.count,
      cover_image: @course.cover_image,
      open_time: @course.open_time
    }
  end

  def get_student_list course
    student_list = course.detail_courses.pluck(:user_id)
    return User.where(id: student_list).pluck(:id, :username).map { |id, name| { id: id, username: name } }
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
      params.permit(Course::COURSE_PARAMS).merge(user_id: @current_user.id)
    end
end
