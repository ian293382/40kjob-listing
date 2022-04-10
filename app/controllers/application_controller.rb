class ApplicationController < ActionController::Base
  #設定多國語系 
    before_action :set_locale

    protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end



#設定多國語系

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
    session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

end
