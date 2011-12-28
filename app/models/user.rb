class User < ActiveRecord::Base
  #  acts_as_authentic do |c|
  #    c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  #  end # block optional
  
  acts_as_authentic do |c|
    c.login_field = :email
  end
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :operates

  has_many :comments
  has_many :flags
  has_many :cheers
  
  attr_accessor :old_password

  validate :validate_old_password, :if => :required_old_password?
  
  def validate_old_password
    errors.add(:old_password) unless valid_password?(self.old_password)
  end
  def before_validation_on_create
    self.login=Numbering.new_number!(self.class.to_s)
  end
  def required_old_password!
    @old_password_required = true
    @password_changed = true
  end

  def required_old_password?
    @old_password_required
  end
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
end
