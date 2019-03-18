require 'test_helper'

class DetailEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detail_event = detail_events(:one)
  end

  test "should get index" do
    get detail_events_url, as: :json
    assert_response :success
  end

  test "should create detail_event" do
    assert_difference('DetailEvent.count') do
      post detail_events_url, params: { detail_event: { event_id: @detail_event.event_id, user_id: @detail_event.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show detail_event" do
    get detail_event_url(@detail_event), as: :json
    assert_response :success
  end

  test "should update detail_event" do
    patch detail_event_url(@detail_event), params: { detail_event: { event_id: @detail_event.event_id, user_id: @detail_event.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy detail_event" do
    assert_difference('DetailEvent.count', -1) do
      delete detail_event_url(@detail_event), as: :json
    end

    assert_response 204
  end
end
