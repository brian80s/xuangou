class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :resource_id
      t.string :resource_type
      t.string :title
      t.text :content
      t.boolean :visible
      t.boolean :isdeleted

      t.timestamps
    end
  end
end
