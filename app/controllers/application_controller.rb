class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_not_home

  def set_not_home
    @home = false
    #code
  end
  def after_sign_in_path_for(resource)
    "/users/mood_monitor"
  end

end
