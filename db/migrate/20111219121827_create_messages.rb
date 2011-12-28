class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :accept_id
      t.integer :tp  #消息类型
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
