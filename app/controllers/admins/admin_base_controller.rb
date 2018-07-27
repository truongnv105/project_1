# frozen_string_literal: true

module Admins
  class AdminBaseController < ApplicationController
    layout 'admin_layout'
    include Admins::SessionsHelper

    def admin_login?
      redirect_to root_url unless logged_in_admin?
    end
  end
end
