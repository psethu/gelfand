class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # below makes access denied errors more user friendly
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Sorry, you do not have permission to view this page."
  	redirect_to root_url
  end

end
