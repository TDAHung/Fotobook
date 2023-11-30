class PendingUsersController < ApplicationController
  layout 'session_layout'
  def navigate_guest
    render 'guests/index'
  end
end
