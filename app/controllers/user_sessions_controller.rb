class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      #如果有请求页面，登录后回到请求页面
      if session[:return_to] 
        redirect_to session[:return_to]
      else
      redirect_to '/'    #设置登录后的地址
      end
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy if current_user
    flash[:notice] = "Logout successful!"
    redirect_to '/login'
  end

end
