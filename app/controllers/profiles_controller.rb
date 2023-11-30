class ProfilesController < ApplicationController
  before_action :check_user_status
  def edit
    @profile = current_user
  end

  def update
    @profile = User.find(params[:id])
    if @profile.update(user_params)
      redirect_to discover_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :img_url, :first_name, :last_name, :status)
  end
end
