module Admin::SessionsHelper
  def admin_login admin
    session[:admin_session] = admin.id
  end

  def admin_logout
    session[:admin_session] = nil
  end

  def logged_in_admin?
    !session[:admin_session].nil?
  end
end
