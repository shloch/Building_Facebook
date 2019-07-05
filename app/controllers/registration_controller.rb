class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    # POST /resource
    def create
     p "yoooo"
    end
end