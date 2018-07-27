# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      callback('Facebook')
    end

    def google_oauth2
      callback('Google_oauth2')
    end

    def twitter
      callback('Twitter')
    end

    def callback(callback)
      if current_user.present?
        create_provider(request.env['omniauth.auth'])
      else
        @user = User.from_omniauth(request.env['omniauth.auth'])

        user_redirect(@user, callback)
      end
    end

    def create_provider(provider)
      provider = current_user.providers.new(
        provider: provider[:provider],
        uid: provider[:uid],
        email: provider[:info][:email],
        token: provider[:credentials][:token]
      )

      provider_redirect(provider)
    end

    def user_redirect(user, callback)
      if user.present?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success',
                                kind: callback
        sign_in_and_redirect user, event: :authentication
      else
        redirect_to new_user_registration_url,
                    alert: t('.account') + callback + t('.notice')
      end
    end

    def provider_redirect(provider)
      if provider.save
        redirect_to edit_user_registration_url(current_user.id),
                    alert: t('.add_success') + provider[:provider]
      else
        redirect_to edit_user_registration_url(current_user.id),
                    alert: t('.linking_was_exist')
      end
    end
  end
end
