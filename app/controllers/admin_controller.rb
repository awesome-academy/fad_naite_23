class AdminController < ApplicationController
  before_action :require_log_in, :admin_user
end
