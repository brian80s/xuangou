# Load the rails application
require File.expand_path('../application', __FILE__)
require File.join(Rails.root, 'lib/authenticated_system.rb')
# Initialize the rails application
Xuangou::Application.initialize!
require 'will_paginate'
Bolide.config do |config|
    config.site_info :name=>'linkHome',
      :title=> '爱炫购',
      :logo=>"logo.png",
      :time_out=>false,
      :config=>{:page_size=>20,:debug=>true},
      :menus=>{"Home" => {"main"=>"index"},
      'Category' => {"categories"=>"show","products"=>"search"}
    }
  end