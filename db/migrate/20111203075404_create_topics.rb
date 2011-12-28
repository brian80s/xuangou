class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.decimal :price
      t.string :place
      t.string :latlng
      t.integer :photo_id
      t.integer :comments_count, :default => 0
      t.integer :flags_count, :default=>0  #举报数量
      t.integer :cheers_count, :default=>0  #推荐数量
      
      t.string :cached_tag_list
      t.integer :user_id

      t.timestamps
    end
  end
end
