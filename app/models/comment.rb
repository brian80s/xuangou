class Comment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true #指定申请的类型/对象
  belongs_to :user
end
