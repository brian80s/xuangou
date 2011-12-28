class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.text :note
      t.integer :sequence
      t.boolean :visible

      t.timestamps
    end
  end
end
