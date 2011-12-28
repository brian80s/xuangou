class Operate < ActiveRecord::Base
  acts_as_tree :order=>'sequence',:counter_cache=>true
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :users
  
  def self.main_menus
#    self.find_all_by_parent_id(1,
#        :select=>"id,name,controller,action",
#        :order=>'sequence')
    self.where(:parent_id=>1).select("id,number,name,controller,action").order('sequence')
  end
  
  #根据parent计算level  
  before_save do |operate|    
    operate.level = operate.parent ?  operate.parent.level+1 : 0    
  end
  
  #这几个函数非常重要
  #得到当前节点指定级次的父亲
  def find_parent_by_level(level)
    get_parent_by_level(self , level) if level<= self.level
  end

  #得到路径上所有的父亲
  def find_full_path_parent
    build_full_path([],self.parent) if self.parent
  end
  
  #返回当前对象的所有树
  def find_tree()
    build_tree([]<<self,self)
  end
  
  #返回某对象的所有树
  # Operate.find_tree()  return all
  # Operate.find_tree(id) return all by id
  # Opreate.find_tree(:name=>'d') return all by conditions
  def self.find_tree(id=nil)
    if id.nil?
      operate=Operate.find_by_parent_id(0)
    elsif id.is_a?(Integer)
      operate=Operate.find(id)
    else
      operate=Operate.find(:first,:conditions=>id) 
    end
    operate.find_tree()
  end
  
  #用于设置所有父权限
  def self.make_operates(opts)
    result=[]
    opts.each { |x| result<<x.find_full_path_parent() }
    for opt in opts
      result<<opt.find_full_path_parent()
      result.delete_if { |x| x.nil? }
      result.uniq    
    end
    opts<<result  if result    
  end
  
  protected
  #寻找所有孩子
  def build_tree(tree,node)
    # 递归调用，在每个元素上执行build_tree，并把当前节点加到tree中
    # 只有ruby才能做到如此简洁易懂！！
    node.children.each {|nd| nd.build_tree(tree<<nd, nd) } 
    tree
  end
  
  #追索所有父亲
  def build_full_path(path,node)
    path<<node 
    node.level==0 ? path : build_full_path(path,node.parent)    
  end
  
  #得到某级别的父亲
  def get_parent_by_level(node ,level)
    node.level==level ? node : get_parent_by_level(node.parent,level)
  end
  
  
end
