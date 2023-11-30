class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query_search

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :user_type, :last_name, :status, :img_url])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def check_user_status
    if current_user && current_user.status != 'active'
      redirect_to pending_path
    end
  end

  private
  def set_query_search
    @query = Album.ransack(params[:q])
  end
end
