class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :resource_id
      t.string :resource_type
      t.string :content
      t.timestamps
    end
  end
end
