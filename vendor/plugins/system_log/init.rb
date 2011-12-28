# 在此设置Route，可以避免在每个应用程序中设置

#class ActionDispatch::Routing::RouteSet
#  alias draw_without_log routes
#  def draw_with_log
#    draw_without_log do     
#      resources :system_log,:collection => { :index=>:get, :clear => :get, :change_level => :get }
#      yield
#    end
#end
#end