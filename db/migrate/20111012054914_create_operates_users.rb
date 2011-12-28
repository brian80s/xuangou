class CreateOperatesUsers < ActiveRecord::Migration
  def self.up
    create_table :operates_users,:id=>false do |t|          
      t.column :user_id,:integer
      t.column :operate_id,:integer
    end
  end

  def self.down
    drop_table :operates_users
  end
end
