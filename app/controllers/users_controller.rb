class UsersController < ApplicationController
   layout "user_center" 
  def info
    
  end
  
  def user_center
    @user = current_user
  end
  
  def new
    @user = User.new
  end
  
    
  def create   
    @user = User.new params[:user]  
    if @user.save  
      flash[:notice] = 'User create successful'  
      redirect_to root_path  
    else  
      render 'new'
    end  
  end  

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

end
