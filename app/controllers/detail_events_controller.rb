class DetailEventsController < ApplicationController
  before_action :set_detail_event, only: [:show, :update, :destroy]

  # GET /detail_events
  def index
    @detail_events = DetailEvent.all

    render json: @detail_events
  end

  # GET /detail_events/1
  def show
    render json: @detail_event
  end

  # POST /detail_events
  def create
    @detail_event = DetailEvent.new(detail_event_params)

    if @detail_event.save
      render json: @detail_event, status: :created, location: @detail_event
    else
      render json: @detail_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /detail_events/1
  def update
    if @detail_event.update(detail_event_params)
      render json: @detail_event
    else
      render json: @detail_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /detail_events/1
  def destroy
    @detail_event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail_event
      @detail_event = DetailEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def detail_event_params
      params.require(:detail_event).permit(:user_id, :event_id)
    end
end
