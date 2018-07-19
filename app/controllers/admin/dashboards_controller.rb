class Admin::DashboardsController < Admin::ApplicationController
  def index
    unless !current_user.nil? && current_user.is_admin?
      redirect_to root_path
    end
  end
end
