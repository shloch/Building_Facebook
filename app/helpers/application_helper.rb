#following tutorial ==> https://bit.ly/30kS3sZ
module ApplicationHelper
        def resource_name
          :user
        end
      
        def resource
          @resource ||= User.new
        end
      
        def devise_mapping
          @devise_mapping ||= Devise.mappings[:user]
        end
        
        # Returns the Gravatar for the given user.
        def gravatar_for(user)
          gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
          gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
          image_tag(gravatar_url, alt: user.name, class: "gravatar")
        end

      
end
