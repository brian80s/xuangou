
module Bolide
  #对标准类型的扩展
  module Numerical
    #使用逗号格式化一个数值类型
    # 1234567.12.commas ->1,234,567.12
    # 1234567.commas ->1,234,567
    def commas   
      #先将它转换为一个字符串，然后将它反转，再用正则表达式来进行操作
      str = self.to_s.reverse   
      str.gsub!(/([0-9]{3})/,"\\1,")   
      str.gsub(/,$/,"").reverse   
    end 
  end
  
  module Datetime
    # format datetime with / and  long format
    def to_long_datetime
      self.strftime("%Y/%m/%d %H:%M")     
    end

    # format datetime with - and shor format
    def to_short_datetime
      self.strftime("%Y/%m/%d")     
    end
  end
end

# 扩展Numeric类
class Numeric # :nodoc
 include Bolide::Numerical
end

class Time
  include Bolide::Datetime
end

class DateTime
  include Bolide::Datetime
end

class NilClass
  def next_number(qty=1)
  end
  
  def -(number)
  end
  
  def region_to(qty=1)    
  end
  
  def region_sizeof(number)
  end
end

class String
  #得到字符串的下一个编号，是对字符串中数值区域的值的增加，
  #如果该字符串没有数值区域，那么返回原字符串
  #例如
  # 'abc'.next_number         -> abc
  # 'abc100'.next_number      ->abc101
  # '100'.next_number         ->101
  # '100abc'.next_number      ->101abc
  # '0100abc'.next_number     ->0101abc
  # '0099abc'.next_number     ->0100abc
  # "abc100".next_number(10)  ->"abc110"
  # "100abc".next_number(10)  ->"110abc"
  # "100abc100".next_number(10)  ->"100abc110"
  def next_number(qty=1)
    self.reverse.sub(/(0*)\d+/) { |match| (match.reverse.to_i+qty.to_i).to_s.rjust(match.length,"0").reverse }.reverse    	
  end
  
   #两个字符串相减，得到两个字符串之间相减的数量
   #例如：
   #  "abc"-"abc"           ->0
   #  "abc110"-"abc100"     ->10
   #  "110abc"-"100abc"     ->10
  def -(number)
    match1 = /\d+/.match(self)
    match2 = /\d+/.match(number)
    (match1 && match2) ? match1[0].to_i - match2[0].to_i : 0
  end
  
  #从当前区段得到下一区段，区段的间隔由qty指定，区段包括首尾部分
  #例如：
  # "a100".region_to(1)      ->"a100"
  # "a100".region_to(2)   ->"a101"
  def region_to(qty=1)
    raise "参数不允许为0" if qty==0
    next_number(qty<0? qty+1:  qty-1)
  end
  #计算两个区段之间的大小，区段是包含首尾部分
  #例如：
  # "a100".region_sizeof("a100")    ->1
  # "a100".region_sizeof("a101")    ->2
  def region_sizeof(number)
    (self-number).abs+1
  end
end


