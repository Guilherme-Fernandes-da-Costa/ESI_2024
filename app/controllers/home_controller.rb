# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to lists_path
    else
      redirect_to login_path
    end
  end
end
