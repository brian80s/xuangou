# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles = Role.create([{:id=>1,:name => 'admin',:number=>'admin' }, { :name => 'users',:number=>'users' }])
User.create([{:login=>"admin",:name => 'admin',:email=>'1244002@qq.com',:password=>"admin",:password_confirmation=>"admin" }])
operate = Operate.create([{:id=>1,:number=>"Root",:name=>"root",:controller=>"main",:action=>"",:sequence=>0,:authable=>0,:visible=>0},
    {:id=>2,:number=>"Home",:name=>"首页",:parent_id=>1, :controller=>"main",:action=>"index",:sequence=>1,:authable=>0,:visible=>1},
  {:id=>3,:number=>"Category",:name=>"分类信息",:parent_id=>1,:controller=>"categories",:action=>"index",:sequence=>2,:authable=>0,:visible=>1},
{:id=>4,:number=>"NewMessage",:name=>"最新炫购",:parent_id=>1,:controller=>"messages",:action=>"isnew",:sequence=>3,:authable=>1,:visible=>1},
{:id=>5,:number=>"HotMessage",:name=>"最热炫购",:parent_id=>1,:controller=>"messages",:action=>"isfriend",:sequence=>4,:authable=>1,:visible=>1},
{:id=>6,:number=>"Apply",:name=>"好友推荐",:parent_id=>1,:controller=>"messages",:action=>"isfriend",:sequence=>5,:authable=>1,:visible=>1}
])