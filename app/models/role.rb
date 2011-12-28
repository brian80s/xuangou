
class Role < ActiveRecord::Base
  validates_presence_of :name,:message=>"名称不能为空"
  validates_presence_of :number,:message=>"编号不能为空"
  validates_uniqueness_of :number, :case_sensitive => false,:message=>"该编号已经存在，编号不能重复"
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :operates
end
