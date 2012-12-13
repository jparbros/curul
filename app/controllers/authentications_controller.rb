class AuthenticationsController < ApplicationController
  def create
      omniauth = request.env['omniauth.auth']
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

      if authentication
        # User is already registered with application        
        flash[:info] = 'Signed in successfully.'

        sign_in_and_redirect(authentication.user)
      elsif current_user.user
        # User is signed in but has not already authenticated with this social network
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
        current_user.apply_omniauth(omniauth)
        current_user.save

        flash[:info] = 'Authentication successful.'
        redirect_to root_url
      else
        # User is new to this application
        user = User.find_or_initialize_by_email(omniauth['extra']['raw_info']['email'])
        user.apply_authorization

        if user.save!
          user.apply_omniauth(omniauth)
          flash[:info] = 'User created and signed in successfully.'
          sign_in_and_redirect(user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to signup_path
        end
      end
    end
end
