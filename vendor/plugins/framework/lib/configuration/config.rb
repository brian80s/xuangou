# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
module Bolide
  def self.config
    yield Config
  end

  module Config
    Site = Struct.new(:name,:title,:description,:keywords,:logo,:time_out,:config,:menus)
    # 设置该应用/站点的基本信息
    # :name  名称
    # :title title
    # :description  说明
    # :keywords
    # :logo 图标
    # +
    #  Bolide.config do |admin|
    #    admin.site_info :name=>'Safore',:title=> 'example.tld',:logo=>"logo.png"
    #  end
    # +
    def self.site_info(info={})
      self.site = Site.new(info[:name], info[:title]||info[:name] ,
                info[:description],info[:keywords] ,info[:logo],info[:time_out],info[:config],info[:menus])
    end

    def self.site
      @@site ||= raise("Bolide not configured: site info not set")    
    end

    def self.site= (value)
      @@site = value 
    end

    ::ActiveRecord::Base.send :include, self
  end

end
