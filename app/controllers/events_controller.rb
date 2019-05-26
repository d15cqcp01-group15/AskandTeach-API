class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create, :user_event, :joined_event]

  # GET /events
  def index
    @events = Event.all.order(created_at: :desc)

    render json: @events.as_json(only: Event::EVENT_AGUMENT, include: [{user: {only: [:id, :username]}}])
  end

  def user_event
    @events = Event.where(user_id: @current_user.id).order(created_at: :desc)

    render json: @events.as_json(only: Event::EVENT_AGUMENT, include: [{user: {only: [:id, :username]}}])
  end

  def joined_event
    event_of_user = @current_user.detail_events

    if event_of_user.blank?
      render json: { message: "Người dùng này chưa tham gia event nào !"}
    else
      event_joined = Event.where(id: event_of_user.pluck(:event_id))
      render json: event_joined.as_json(only: Event::EVENT_AGUMENT, include: [{user: {only: [:id, :username]}}])
    end
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
      params.permit(:title, :user_id, :address, :district, :city, :uptime, :price, :description, :open_time).merge(user_id: @current_user.id)
    end

    def json_handler(event)
      return { id: event.id,
               title: event.title,
               creator: event.user.username,
               adress: event.address,
               joined_student: event.detail_events.count,
               price: event.price,
               description: event.description,
               open_time: event.open_time
      }
    end
end
