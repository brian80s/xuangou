class CreateOperatesRoles < ActiveRecord::Migration
  def self.up
    create_table :operates_roles ,:id=>false do |t|
      t.column :role_id,:integer
      t.column :operate_id,:integer
    end
  end

  def self.down
    drop_table :operates_roles
  end
end
