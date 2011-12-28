
class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  #before_filter :login_from_cookie
  #layout "application",:except=>[:login]
  #  layout :account_layout   
  #
  #  def account_layout   
  #    action_name=="login" ? "login" : "application"  
  #  end   

  #用户列表
  def index
    if params.has_key?('ft') && params[:ft]
      @users = User.paginate(:conditions=>params[:ft],:page => params[:page],:joins=>"left join roles_users on (users.id = roles_users.user_id)", :per_page =>Bolide::Config.site.config[:page_size]||20)   
    else
      @users = User.paginate(:page => params[:page]||1, :per_page =>Bolide::Config.site.config[:page_size]||20)
    end
  end
  def filter
    if params.has_key?('param') &&params[:param]
      option =params[:param].delete_if {|key,v| v == ''}
      
      condition = "(1=1)"
      #用户姓名
      condition += " AND users.name like '%#{option[:ol_name]}%'"  if option.has_key?('ol_name')  
      #用户号
      condition += " AND users.login like '%#{option[:ol_number]}%'"  if option.has_key?('ol_number')
    end
    #render :action => "index"
    redirect_to :action => "index",:ft=>condition
  end
  #登录
  def login
    @user_session = UserSession.new
    return unless request.post?
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to '/'    #设置登录后的地址
    else
      render :action => :new
    end
    #    begin
    #      self.current_user = User.authenticate(params[:login], params[:password])
    #      if logged_in?
    #        if params[:remember_me] == "1"
    #          self.current_user.remember_me
    #          cookies[:auth_token] = { :value => self.current_user.remember_token , 
    #            :expires => self.current_user.remember_token_expires_at }
    #        end
    #        redirect_back_or_default(root_path)
    #        #flash[:notice] = "Logged in successfully"
    #        cookies.delete :login_times                        
    #      end
    ##    rescue StandardError => error
    ##      flash[:notice]= error
    #    end
  end

  #新建用户
  def signup
    @user = User.new(params[:user])
    return unless request.post?
    
    @user.transaction do
      @user.roles.delete_all
      @user.roles<<role=Role.find_by_number("users") 
      if role
        @user.operates.delete_all
        @user.operates<<role.operates
      end
      @user.save!
    end
    #self.current_user = @user
    redirect_back_or_default(:action=>'index') 
    flash[:notice] = "创建用户成功"    
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'     
  end
  
  #登出
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    #flash[:notice] = "You have been logged out."
    redirect_back_or_default(root_path) 
  end
  
  #维护
  def setting
    @user = User.find(params[:id])
    role=@user.roles.find(:first)
    @operates=role.operates if role   
  end
  
  # DELETE /depts/1
  # DELETE /depts/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to url_for(:action=>:index) }
      format.xml  { head :ok }
    end
  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  # PUT /bulletins/1
  # PUT /bulletins/1.xml
  def update
    begin
      @user = User.find(params[:id])
      raise "请选择角色类型"  if params[:role].blank?
      if params[:user][:password_confirmation]!=params[:user][:password]
        flash[:notice] = '输入的密码不匹配.'
        redirect_to account_path
      else
        respond_to do |format|
          @user.transaction do
            if @user.update_attributes(params[:user])
              @user.roles.delete_all
              @user.roles<<role=Role.find(params[:role]) if params[:role] #add by yj 
              if role
                @user.operates.delete_all
                @user.operates<<role.operates
              end
              format.html { redirect_to account_path}
              format.xml  { head :ok }
            else
              format.html { render :action => "edit" }
              format.xml  { render :xml =>user.errors.to_xml }
            end
          end
        end
      end
    rescue StandardError => error  #显示错误信息         
      flash[:notice]= error
      @user.errors.add(:error,error) if @user
      render :action => "edit"
    end
  end
  
  # PUT /bulletins/1
  # PUT /bulletins/1.xml
  def setting_update
    begin
      @user = User.find(params[:id])
      raise "请选择角色类型"  if params[:role].blank?
      if params[:user][:password_confirmation]!=params[:user][:password]
        flash[:notice] = '输入的密码不匹配.'
        redirect_to setting_account_path
      else
        respond_to do |format|
          @user.transaction do
            if @user.update_attributes(params[:user])
              @user.roles.delete_all
              @user.roles<<role=Role.find(params[:role]) if params[:role] #add by yj 
              if role
                @user.operates.delete_all
                @user.operates<<role.operates
              end
              format.html { redirect_to setting_account_path}
              format.xml  { head :ok }
              flash[:notice] = '修改成功.'
            else
              format.html { render :action => "setting" }
              format.xml  { render :xml =>user.errors.to_xml }
            end
          end
        end
      end
    rescue StandardError => error  #显示错误信息         
      flash[:notice]= error
      @user.errors.add(:error,error) if @user
      render :action => "edit"
    end
  end
  
  # POST /role/1/authenticated
  # 用户授权
  def authenticated
    user = User.find(params[:id])
    user.transaction do
      user.operates.delete_all()
      if params[:user]
        operates= Operate.find(params[:user][:operates])  
        #operates =Operate.make_operates(operates) if operates
        user.operates<<operates if operates
      end
      user.save!
    end
    redirect_to account_path
  end  
  
  # GET /role/1/admin
  # 用户授权管理
  def admin
    @user = User.find(params[:id])
    @user.check_operates
    role=@user.roles.find(:first)
    @operates=role.operates if role    
  end
  
  def search
    @users = User.find(:all,
      :conditions =>["login like ? or name like ?", '%'+params[:name]+'%','%'+params[:name]+'%'] )
    render :partial=>'users',:object=>@users
  end
end
