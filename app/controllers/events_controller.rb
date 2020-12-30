class EventsController < ApplicationController
  before_action :set_range, only: [:index]
  # GET /events
  # GET /events.json
  def index
    @events = Event.between(range: @range, field: 'start_time')
  end
end
