class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :resource_id
      t.string :resource_type
      t.timestamps
    end
  end
end
