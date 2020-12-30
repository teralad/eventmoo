class ApplicationController < ActionController::Base

  def set_range
    @range = DatetimeRange.new(params[:start_time], params[:end_time])
  end
end
