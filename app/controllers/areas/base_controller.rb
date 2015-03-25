class Areas::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_area, only: [:show]
  def index
  	@areas = current_user.areas
  end

  def show
  	
  end

  private
    def set_area
    	@area = Area.find(params[:id])
    end
end
