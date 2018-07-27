# frozen_string_literal: true

module Users
  class ProvidersController < ApplicationController
    def destroy
      @provider = Provider.find_by id: params[:id]

      if !@provider.nil?
        user_id = @provider.user

        if @provider.destroy
          redirect_to edit_user_registration_url user_id
          flash[:success] = t '.disable_linking_success'
        end
      else
        redirect_to request.referer
        flash[:danger] = t '.linking_not_exist'
      end
    end
  end
end
