# 
# 通过该扩展，使ActiveRecord::Base/也就是应用程序的model中可以访问current_user
# 这样很多model中的函数都可以不用再传递current_user，使程序大为简化
# 
# 可以通过类对象和实例变量访问current_user，如：
# Dept.current_user
# or 
# dept=Dept.new()
# dept.current_user
#
module Bolide; end
module Bolide::ModelUserAccess; end
# This is a module aimed at making the current_user available to ActiveRecord models for permissions.
module Bolide::ModelUserAccess
  DefaultCurrentUserMenthod = :current_user
  # 扩展到Controller得到current_user
  # 并传给ActiveRecord::Base
  module Controller    
    def self.included(base)
      base.prepend_before_filter :assign_current_user_to_models
    end

    # We need to give the ActiveRecord classes a handle to the current user. We don't want to just pass the object,
    # because the object may change (someone may log in or out). So we give ActiveRecord a proc that ties to the
    # current_user_method on this ApplicationController.
    # ActiveRecordPermissions needs to know what method on your ApplicationController will return the current user,
    # if available. This defaults to the :current_user method. You may configure this in your environment.rb if you
    # have a different setup.
    def assign_current_user_to_models
      ActiveRecord::Base.current_user_proc = proc {send(DefaultCurrentUserMenthod)}
    end
  end

  # 扩展到model使其可以访问current_user
  module Model
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # The proc to call that retrieves the current_user from the ApplicationController.
      attr_accessor :current_user_proc

      # Class-level access to the current user
      def current_user
        ActiveRecord::Base.current_user_proc.call if ActiveRecord::Base.current_user_proc
      end
    end

    # Instance-level access to the current user
    def current_user
      self.class.current_user
    end
  end
end

ActionController::Base.class_eval {include Bolide::ModelUserAccess::Controller}
ActiveRecord::Base.class_eval {include Bolide::ModelUserAccess::Model}
