class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_default_params, only: [:show]
  before_action :set_range, only: [:show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @availabe_slots = @user.get_availability(@range)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_default_params
      params[:start_time] ||= "2019-01-19"
      params[:end_time] ||= "2019-02-01"
    end
end
