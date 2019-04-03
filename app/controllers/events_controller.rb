class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events.as_json(only: [:id, :title, :address, :district, :city, :uptime, :price, :amount_student], include: [{user: {only: [:id, :username]}}])
  end

  # GET /events/1
  def show
    render json: json_handler(@event)
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.permit(:title, :user_id, :address, :district, :city, :uptime, :price, :description)
    end

    def json_handler(event)
      return { id: event.id,
               title: event.title,
               creator: event.user.username,
               adress: event.address,
               joined_student: event.detail_events.count,
               price: event.price,
               description: event.description
      }
    end
end
