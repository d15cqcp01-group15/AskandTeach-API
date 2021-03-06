class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create]

  # GET /topics
  def index
    @topics = Topic.all

    render json: @topics.as_json(only: Topic::TOPIC_DATA, include: [{creator: {only: [:id, :username]}}])
  end

  # GET /topics/1
  def show
    render json: @topic.as_json(only: Topic::TOPIC_DATA, include: [{creator: {only: [:id, :username]}}])
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: :created, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      render json: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params
      params.permit(:title, :content, :topic_type).merge(user_id: @current_user.id)
    end
end
