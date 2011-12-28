class CreateNumberings < ActiveRecord::Migration
  def self.up
    create_table :numberings do |t|
      t.column :name,:string  #名称
      t.column :types,:string  #类型
      t.column :template,:string,:default=>'' # 模板
      t.text :note
    end
  end

  def self.down
    drop_table :numberings
  end
end
