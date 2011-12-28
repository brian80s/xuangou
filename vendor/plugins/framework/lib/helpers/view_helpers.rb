#
# 该module定义那些被view使用的方法
#

require 'time'

module Bolide::Helpers::ViewHelpers
  
  include Bolide::Helpers::TabControl
  include Bolide::Helpers::MainControl
  include Bolide::Helpers::DebugHelpers
  
  # 在一定的时间后自动注销
  #
  # *Examples*
  #
  # # index.html.erb
  # <%= link_to '退出',logout_account_path,:id=>:logoutLink %>
  # <%= logout_after(10) %>
  #
  def logout_after(seconds)
    <<-Text
<script type="text/javascript">
  var quitID=0;
  function logout()
  {
            var logoutLink = document.getElementById('logoutLink');
            if(logoutLink) { logoutLink.click(); }
  }
  document.onmousemove = function(){ clearTimeout ( quitID );  quitID = setTimeout ("logout();", #{seconds*1000}); };
</script>
    Text
  end

  # 该特性用于防止表单重复提交
  # 类似struts的token，使用session保存token，
  # 调用check_token后就把session里的token清掉，所以不能重复调用。
  #
  # 因为有些界面可能会有多个表单，这些表单最好共用同一个token，
  # 不然提交过来的token很难验证，所以这里做了处理，不会多次生成。
  #
  # 可参考：http://qiezi.javaeye.com/blog/37781
  #
  # *Examples*
  #
  # # form.html.erb
  # <%= form_tag(:controller => "test", :action => "test") %>
  #   <%= token_field %>
  #   <%= submit_tag "提交" %>
  # </form>
  #
  # # application.rb
  # class ApplicationController < ActionController::Base
  #   include Safore::Utility
  #   ...
  # end
  #
  # # TestController.rb
  # 方法1：
  #  class TestController < ApplicationController
  #    def test
  #      unless check_token
  #        return redirect_to("/")
  #      end
  #      #...
  #    end
  #  end
  #
  #  #方法2：
  #  class TestController < ApplicationController
  #    before_filter :check_token, : only => ["test"], : redirect_to => "/"
  #
  #    def test
  #      #...
  #    end
  #  end
  #
  def token_field
    hidden_field_tag(:__token__, (@__token__ ||= (session[:__token__] =
            Digest::SHA1.hexdigest((Time.now.to_i + rand(0xffffff)).to_s)[0..39])))
  end

  
  

  
  def select_options_for(symbol,options={})
    Object.const_get(symbol.to_s).find(:all,
      :conditions => options[:conditions] || "id<>0" ,
      :order => options[:order] || "id" )
  end
  
  def site
    Bolide::Config.site
  end

end
