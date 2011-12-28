class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name, :string
      t.column :number, :string
      t.column :note,:string                      #说明
    end
  end

  def self.down
    drop_table :roles
  end
end
