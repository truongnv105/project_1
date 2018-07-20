class Admin::SessionsController < Admin::AdminApplicationController
  layout false

  def new
    @admin = Admin.new
  end

  def create
    admin = Admin.find_by email: params[:session][:email].downcase

    if admin && admin.authenticate(params[:session][:password])
      admin_login admin
      redirect_to admin_dashboards_url
    else
      render :new
      flash.now[:danger] = t ".invalid_data"
    end
  end

  def destroy
    admin_logout
    flash[:success] = t ".logout_success"
    redirect_to root_url
  end
end
