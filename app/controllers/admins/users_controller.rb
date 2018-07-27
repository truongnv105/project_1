# frozen_string_literal: true

module Admins
  class UsersController < Admins::AdminsBaseController
    before_action :admin_login?
    before_action :load_user, except: %i[index new create]

    def index
      @users = User.paginate page: params[:page],
                             per_page: Settings.users.pages.per
    end

    def show;  end

    def edit;  end

    def update
      @user.update_attributes user_params

      redirect_to admins_users_path if @user.save
    end

    def destroy
      redirect_to request.referer if @user.destroy
    end

    def user_params
      params.require(:user).permit :name, :email, :avatar
    end

    def load_user
      @user = User.find_by id: params[:id]
      redirect_to admins_dashboards_url if @user.nil?
    end
  end
end
