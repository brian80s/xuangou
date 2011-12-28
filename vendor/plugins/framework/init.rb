# Include hook code here


require 'utility'
require 'helper'
require 'configuration/config'
Dir["#{File.dirname __FILE__}/lib/extensions/*.rb"].each { |file| require file }
#Dir["#{File.dirname __FILE__}/lib/helpers/*.rb"].each { |file| require file }

#ActiveRecord::Base.send(:include, ActsAsChattable)
ActionView::Base.module_eval do
  include Bolide::Helpers
end

