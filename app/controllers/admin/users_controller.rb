class Admin::UsersController < Admin::AuthorizationsController
  def index
    @users = User.includes(:photos).includes(:albums).includes(:followers).includes(:followees).where(user_type: 'user').page(params[:page]).per(15)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

  def edit
    @profile = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  private
  def user_params
    if params[:user][:password] == ''
      params.require(:user).permit(:img_url, :first_name, :last_name, :email, :status)
    else
      params.require(:user).permit(:img_url, :first_name, :last_name, :email, :password, :status)
    end
  end
end
