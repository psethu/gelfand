class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # below makes access denied errors more user friendly
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Access to page denied."
  	redirect_to root_url
  end
end
