class CreateOperates < ActiveRecord::Migration
  def self.up
    create_table :operates do |t|
      t.column :number,:string
      t.column :name,:string
      t.column :parent_id , :integer
      t.column :controller,:string
      t.column :action,:string      
      t.column :protocol,:string,:default=>'GET'    #请求协议POST/GET/PUT/DELETE
      t.column :note,:string                      #说明
      t.column :sequence,:integer,:default=>0  #显示位置,顺序
      t.column :level, :integer
      t.column :operates_count,:integer,:default=>0
      # 是否需要授权
      t.column :authable,:boolean,:default=>true
      # 是否显示在主界面上
      t.column :visible,:boolean,:default =>true
    end
    
    add_index :operates,:controller 
    add_index :operates,:action
  end

  def self.down
    drop_table :operates
  end
end
