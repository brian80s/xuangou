# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
module Bolide; end
module Bolide::Helpers; end

Dir["#{File.dirname __FILE__}/helpers/*.rb"].each { |file| require file }

module Bolide::Helpers
  include Bolide::Helpers::ViewHelpers
end