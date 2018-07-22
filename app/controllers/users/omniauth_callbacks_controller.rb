class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("Facebook")
  end

  def google_oauth2
    generic_callback("Google_oauth2")
  end

  def twitter
    generic_callback("Twitter")
  end

  def generic_callback provider
    if !current_user.nil?
      if !current_user.providers.where(provider: request.env["omniauth.auth"]["provider"],
          uid: request.env["omniauth.auth"]["uid"]).present?
        current_user.providers.create(provider: request.env["omniauth.auth"]["provider"],
        uid: request.env["omniauth.auth"]["uid"], email: request.env["omniauth.auth"]["info"]["email"],
        token: request.env["omniauth.auth"]["credentials"]["token"])
        redirect_to edit_user_registration_url(current_user.id), alert: t(".add_success") + provider
      else
        redirect_to edit_user_registration_url(current_user.id), alert: t(".linking_was_exist")
      end
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if !@user.nil?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to new_user_registration_url, alert: t(".account") + provider + t(".notice")
      end
    end
  end
end
