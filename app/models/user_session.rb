
class UserSession < Authlogic::Session::Base
  attr_accessor :login,:email
  
  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end