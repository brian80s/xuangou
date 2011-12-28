# 在此设置Route，可以避免在每个应用程序中设置

class ActionController::Routing::RouteSet
  alias draw_without_log draw
  def draw_with_log
    draw_without_log do |map|      
      map.resources :system_log,:collection => { :clear => :get, :change_level => :get }
      yield map
    end
  end
  alias draw draw_with_log
end