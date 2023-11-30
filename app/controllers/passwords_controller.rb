class PasswordsController < ApplicationController
  before_action :check_user_status

  def update
    @profile = User.find(current_user.id)
    if @profile.update(user_params)
      redirect_to new_session_user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password)
  end
end
