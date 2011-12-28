class Numbering < ActiveRecord::Base

  #根据类型产生一个新的编码,同时保存到数据库中
  def self.new_number!(type)
    numbering = self.get_numbering(type)
    number = numbering.template.next_number
    numbering.update_attributes(:template=> number)
    number
  end

  #  #根据类型产生一个新的编码
  def self.new_number(type)
    numbering = self.get_numbering(type)
    numbering.template.next_number
  end

  private
  def self.get_numbering(type)
    numbering = Numbering.find_or_create_by_types(type)
    if numbering.template.blank?
      model = type.to_s.singularize.camelize.constantize
      numbering.update_attributes(:name=>model.class_name,:template=>"#{type}00000")
    end
    numbering
  end
end
