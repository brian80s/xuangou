# 
# 该module用于定义那些被Controller使用的公有函数
# 通常在ApplicationController被引用
# 
# class ApplicationController < ActionController::Base
#   include Safore::Utility
#   ...
# end
#
module Bolide
  #
  module Utility
    public
    
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
    def check_token   
      return true if !params[:__token__] 
      if  session[:__token__] == params[:__token__]   
        session[:__token__] = nil  
        session.update   
        return true  
      end  
      false     
      redirect_to :back       
    end  
  end
end
