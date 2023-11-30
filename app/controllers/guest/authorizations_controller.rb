class Guest::AuthorizationsController < ApplicationController
  before_action :check_user_signin

  def check_user_signin
    if current_user.nil?
      redirect_to guest_authorizations_path
    end
  end
end
