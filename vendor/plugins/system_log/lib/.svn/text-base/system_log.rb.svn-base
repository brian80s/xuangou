class SystemLog  
  class << self

    
    def paginate(options_or_page = {})
      find_all.paginate(options_or_page).collect! do |log|
        parse(log)
      end
    end
  
    def clear
      File.open(logfile_path, 'w') do |f|
        f.print ''
      end    
    end

    private
    
    
    def find_all
      File.open(logfile_path) do |f|
        f.read.split("\nProcessing ").reverse
      end
    end
    
    # 日志文件的路径，一般在RAILS_ROOT/log下，根据环境配置
    # 依次记录到product.log development.log test.log中
    def logfile_path
      File.join(RAILS_ROOT, "log", "#{ENV['RAILS_ENV']}.log")
    end
    
    def parse(log)
      log.gsub!("\n","<br/>").gsub!(/\e\[[\d;m]+/,'')
    end
  end
end