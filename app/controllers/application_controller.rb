class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # below makes access denied errors more user friendly
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Sorry, you do not have permission to view this page."
  	redirect_to root_url
  end

  # allows additional params on devise signup
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, individual_attributes: [:f_name, :l_name, :role]) }
  end

end
