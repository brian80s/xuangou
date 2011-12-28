class FrameworkGenerator < Rails::Generator::Base 
  def manifest
    record do |m| 
      m.file 'demo_controller.rb', 'app/controllers/demo_controller.rb'
      m.file 'demo_helper.rb', 'app/helpers/demo_helper.rb'
      m.directory 'app/views/demo'
      m.file 'index.rhtml', 'app/views/demo/index.rhtml'

      m.file 'edit_tabs.css', 'public/stylesheets/edit_tabs.css'
      m.file 'errors.css', 'public/stylesheets/errors.css'
      m.file 'style.css', 'public/stylesheets/style.css'
      
      m.file 'edit_tabs.js', 'public/javascripts/edit_tabs.js'	
      m.file 'navbar.js', 'public/javascripts/navbar.js'	
      m.directory 'public/images/framework'
	  
      #m.file 'close.gif', 'public/images/framework/close.gif'
    end
  end
end
