require 'test_helper'

class DetailCoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detail_course = detail_courses(:one)
  end

  test "should get index" do
    get detail_courses_url, as: :json
    assert_response :success
  end

  test "should create detail_course" do
    assert_difference('DetailCourse.count') do
      post detail_courses_url, params: { detail_course: { course_id: @detail_course.course_id, user_id: @detail_course.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show detail_course" do
    get detail_course_url(@detail_course), as: :json
    assert_response :success
  end

  test "should update detail_course" do
    patch detail_course_url(@detail_course), params: { detail_course: { course_id: @detail_course.course_id, user_id: @detail_course.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy detail_course" do
    assert_difference('DetailCourse.count', -1) do
      delete detail_course_url(@detail_course), as: :json
    end

    assert_response 204
  end
end
