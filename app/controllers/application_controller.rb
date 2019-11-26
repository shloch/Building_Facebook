class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_logged_in_user_and_notification

  def redirect_to_back_or_default(default = root_url)
    if request.env['HTTP_REFERER'].present? and request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to request.env['HTTP_REFERER']
    else
      redirect_to default
    end
  end

  protected

  def configure_permitted_parameters
    attributes = %i[name email date_of_birth gender mobile]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def get_logged_in_user_and_notification
    @logged_user = current_user
    if @logged_user
      @requests_received = Friendship.where(invited_id: @logged_user).includes(:inviting_friend).where(status: 'pending')
    end
  end
end
