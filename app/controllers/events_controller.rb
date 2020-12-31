class EventsController < ApplicationController
  before_action :set_default_params
  before_action :set_range, only: [:index]

  # GET /events
  # GET /events.json
  def index
    @events = Event.between(range: @range, field: 'start_time').order(:start_time)
  end

  private
    def set_default_params
      params[:start_time] ||= "2019-01-15T00:00"
      params[:end_time] ||= "2019-02-15T00:00"
    end
end
