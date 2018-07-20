class Admin::UsersController < Admin::AdminApplicationController
  before_action :admin_login?
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.paginate page: params[:page], per_page: Settings.users.pages.per
  end

  def show;  end

  def edit;  end

  def update

    @user.update_attributes user_params

    if @user.save
      redirect_to admin_users_path
    end
  end

  def destroy

    if @user.destroy
      redirect_to request.referer
    end

  end

  def user_params
    params.require(:user).permit :name, :email, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]

    if @user.nil?
      flash[:danger] = t ".user_not_exist"
      redirect_to admin_dashboards_url
    end
  end
end
