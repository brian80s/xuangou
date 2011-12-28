# 显示和清理系统日志
class SystemLogController < ActionController::Base
  # 页面布局
  layout 'system_log'
  # 默认每页显示20条记录
  PER_PAGE = 20
	
  def index
    @logs = SystemLog.paginate(:page => params[:page], :per_page => PER_PAGE )
  end
	
  def clear
    SystemLog.clear
    redirect_to :action => :index
  end
	
  # 改变ActionView的查找路径，ActionView的默认查找路径为RAILS_ROOT/app/views
  prepend_view_path [File.join(File.dirname(__FILE__), '..', "public")]
end