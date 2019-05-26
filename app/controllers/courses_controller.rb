class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create, :user_course, :joined_course, :close_course]

  # GET /courses
  def index
    @courses = Course.where(state: true).order(created_at: :desc)

    render json: @courses.as_json(only: Course::JSON_AGUMENT, include: [{user: {only: [:id, :username, :profile_image]}}])
  end

  def user_course
    @courses = Course.where(user_id: @current_user.id, state: true).order(created_at: :desc)
    render json: @courses.as_json(only: Course::JSON_AGUMENT, include: [{user: {only: [:id, :username, :profile_image]}}])
  end

  def close_course
    course = Course.where(id: params[:course_id], user_id: @current_user.id).first
    course.state = false

    if course.save
      render json: { message: "Đóng khoá học thành công !" }
    else
      render json: { error: "Đóng khoá học không thành công !" }
    end
  end

  def joined_course
    course_of_user = @current_user.detail_courses
    if course_of_user.blank?
      render json: { message: "Người dùng này chưa tham gia khoá học nào !"}
    else
      course_joined = Course.where(id: course_of_user.pluck(:course_id))
      render json: course_joined.as_json(only: Course::JSON_AGUMENT, include: [{user: {only: [:id, :username, :profile_image]}}])
    end
  end

  # GET /courses/1
  def show
    render json: handle_detail_course(@course)
  end

  def get_student_list course
    student_list = course.detail_courses.pluck(:user_id)

    return User.where(id: student_list).pluck(:id, :username, :profile_image).map { |id, name, profile_image| { id: id, username: name, profile_image: profile_image } }
  end

  def handle_status(course)
    return 'openning' if Time.at(course.deadline_of_registration).future?
    'closed'
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

    def handle_detail_course(course)
      {
        id: course.id,
        name: course.user.username,
        price: course.price,
        uptime: course.uptime,
        skill: course.skill,
        district: course.district,
        city: course.city,
        longitude: course.longitude,
        latitude: course.latitude,
        address: course.address,
        description: course.description,
        student_list: get_student_list(course),
        amount_student: course.detail_courses.count,
        class_opened: course.user.courses.count,
        cover_image: course.cover_image,
        open_time: course.open_time,
        status: handle_status(course),
        deadline_of_registration: course.deadline_of_registration,
        user: {
          id: course.user.id,
          username: course.user.username,
          profile_image: course.user.profile_image,
          phone_number: course.user.phone_number
        }
      }
    end
end
