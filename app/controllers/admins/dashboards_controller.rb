# frozen_string_literal: true

module Admins
  class DashboardsController < Admins::AdminBaseController
    before_action :admin_login?

    def index; end
  end
end
