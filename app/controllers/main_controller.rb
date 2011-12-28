class MainController < ApplicationController
 def index
    @main_menus ||= Operate.main_menus
    @topics = Topic.select("topics.id,title,price,place,latlng,photo_id,comments_count,flags_count,cheers_count,cached_tag_list,user_id,topics.created_at,users.name").joins("left join users on (topics.user_id = users.id)").order("topics.id desc").limit(10)
  end
end
