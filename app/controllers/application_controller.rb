# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[phone_number name avatar birthday email password
                         password_confirmation remember_me]
    )
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password])
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[phone_number name avatar email birthday password
                                password_confirmation current_password]
    )
  end
end
