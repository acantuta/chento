class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
  end

  def inside
  	if current_user.admin?
  		redirect_to admin_root_url 
  	else
  		redirect_to areas_root_url
  	end
  end
  
  
end
