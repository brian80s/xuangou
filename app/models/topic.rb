class Topic < ActiveRecord::Base
  
  has_many :flags,:foreign_key => "resource_id" , :dependent => :destroy
  has_many :cheers,:foreign_key => "resource_id" , :dependent => :destroy
  has_many :comments,:foreign_key => "resource_id" , :dependent => :destroy
end
