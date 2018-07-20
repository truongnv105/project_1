class Admin::DashboardsController < Admin::AdminApplicationController
  before_action :admin_login?

  def index
  end
end
