class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :get_logged_in_user
    

    protected

    def configure_permitted_parameters
        attributes = [:name, :email,:date_of_birth, :gender, :mobile]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

    def get_logged_in_user
        @logged_user = current_user
    end

     
end
