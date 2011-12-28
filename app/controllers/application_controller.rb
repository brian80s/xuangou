class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  include AuthenticatedSystem
  before_filter :main_menus,:set_local 
  
  #  filter_parameter_logging "password" 
  
  #  protected
  def main_menus
    @main_menus ||= Operate.main_menus
    @menu = ""
    if menu = Bolide::Config.site.menus
      menu.each do |key,value|
        @menu = key if(v = value[controller_name]) && (v.is_a?(Array) ? v.include?(action_name) : v == action_name)
      end
    end
  end
  protected

  def set_local
    if params[:locale]&&["en","zh-CN"].include?(params[:locale])
      session[:locale]=params[:locale]
    end
    I18n.locale = session[:locale]||I18n.default_locale
  end
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
end
