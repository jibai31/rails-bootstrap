class AuthenticationsController < Devise::OmniauthCallbacksController
  def google_oauth2
    try_sign_in_user
  end

  def facebook
    try_sign_in_user
  end

  def twitter
    try_sign_in_user
  end

  private

  def try_sign_in_user
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
    user = current_user || User.find_by_email(omni.info.email)
    if authentication
      # The user has already authenticated with this provider
      flash.notice = "Bienvenue !"
      sign_in_and_redirect authentication.user
    elsif user
      # The user is currently signed in, but with another provider
      user.add_provider!(omni)
      flash.notice = "Bienvenue !"
      sign_in_and_redirect user
    else
      # No authenticated user, and unknown provider
      user = User.new
      user.apply_omniauth(omni)

      if user.save
        flash.notice = "Bienvenue !"
        sign_in_and_redirect user
      else
        # User validation failed
        # The oauth info did not contain any email (eg, Twitter account)
        # Backup the API data for later use during registration
        session['devise.omniauth'] = omni.except('extra')

        flash.notice = "C'est presque bon ! Entrez un email pour finir votre enregistrement."
        redirect_to new_user_registration_path
      end
    end
  end
end
