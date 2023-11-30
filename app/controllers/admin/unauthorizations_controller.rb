class Admin::UnauthorizationsController < ApplicationController
  before_action :check_user_status
  layout 'session_layout'
end
