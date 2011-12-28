# 用于在Debug状态下的一些函数
module Bolide::Helpers::DebugHelpers
  # 应用程序版本 ver.svn.db
  def version(ver="1.0")
    "#{ver}.#{db_ver}"
    #"#{ver}.#{svn_ver.blank? ? 0 : svn_ver}.#{db_ver}"
    #"Rails版本=>#{RAILS_GEM_VERSION}  数据库版本=>#{db_ver}  Svn版本=>#{svn_ver}"
  end
  
  private
  
  # 当前数据库版本
  def db_ver
    ActiveRecord::Migrator.current_version
  end
  # 当前应用程序版本
  def svn_ver
    file = File.exist?("#{RAILS_ROOT}/.svn/entries") ? "#{RAILS_ROOT}/.svn/entries" : 
    (File.exist?("#{RAILS_ROOT}/_svn/entries") ? "#{RAILS_ROOT}/_svn/entries" : nil)
    flag=false
    File.readlines(file).each do |line| 
      if line.chomp=="dir" && !flag
        flag = true
      elsif flag
        return line.chomp
      end
    end
    rescue
  end
end