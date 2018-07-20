class Admin::AdminApplicationController < ApplicationController
  layout "admin_layout"
  include Admin::SessionsHelper

  def admin_login?
    unless logged_in_admin?
      redirect_to root_url
    end
  end
end
