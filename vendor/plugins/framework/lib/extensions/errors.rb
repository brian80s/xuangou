module ActiveRecord 
  # 本地化错误信息 在module中注意写上message信息 validates_presence_of :title, :message =>
  # "请输入产品名称。"
  #  validates_presence_of :description, :message => "请输入产品描述。"
  #  validates_presence_of :image_url, :message => "请输入产品图片连接。"
  #  validates_numericality_of :price, :message => "请输入正确的产品价格。"
  #  validates_uniqueness_of :title, :message => "该产品名名称已存在。"
  # 
  # 相关的参考： http://www.cnblogs.com/yuandong/archive/2007/11/12/957218.html http://wiki.rubyonrails.org/rails/pages/OverridingRailsMessagesInAnotherLanguage
#  class Errors 
#    begin 
#      @@default_error_messages.update( { 
#          :inclusion => "不在指定范围内", 
#          :exclusion => "超过了指定范围", 
#          :invalid => "格式无效", 
#          :confirmation => "验证错误", 
#          :accepted => "不被接受", 
#          :empty => "不能为空", 
#          :blank => "不能为空", 
#          :too_long => " 太长了 (最大长度为 %d 个字节)", 
#          :too_short => " 太短了(最短为 %d 个字节)", 
#          :wrong_length => " 长度错误 (长度 %d)", 
#          :taken => "已经存在", 
#          :not_a_number => "不是一个数字", 
#        }) 
#    end 
#  end 
end

module ActionView #nodoc 
  module Helpers 
    module ActiveRecordHelper 
      #覆盖默认的函数
      def error_messages_for(object_name, options = {}) 
        options = options.symbolize_keys 
        object = instance_variable_get("@#{object_name}") 
        if object && !object.errors.empty? 
          error_lis = [] 
          object.errors.each{ |attr,msg| error_lis << content_tag("li", msg) if attr!= 'error' } #需要过滤掉用户自定义的错误信息
          content_tag("div", 
            content_tag(options[:header_tag] || "h2", "操作失败，发生#{error_lis.size}个错误:" ) + 
              content_tag("ul", error_lis), "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation" ) 
        end         
      end 
      
    end 
  end 
end
