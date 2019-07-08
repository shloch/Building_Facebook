class RegistrationsController < ApplicationController
   

    
    def home
        if !user_signed_in?
            redirect_to "/staticpages/home"
        
        else
         
          
        end
    end
end