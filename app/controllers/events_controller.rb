class EventsController < ApplicationController
    def index
        @events = Event.all
    end

    def new
    end

    def create
        @event = Event.new(event_params)
        @event.user_id = params[:creator_id]
        @event.name = params[:event][:name]
        @event.description = params[:event][:description]
        @event.lat = params[:lat]
        @event.lon = params[:lon]

        @event.save
        if @event.save
            redirect_to root_path
        else
            redirect_to "/events/new"
        end
    end

    def show
    end

    private
        def event_params
            params.require(:event).permit(:name, :description, :user_id)
        end
end
