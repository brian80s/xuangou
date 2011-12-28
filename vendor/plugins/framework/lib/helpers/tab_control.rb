# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

module Bolide::Helpers::TabControl
  # 页签控件，生成可以切换的页签
  #
  # 该功能由三个函数组成，分别为：
  # tab_control_for: 包含link_to_tab生成的内容，形成页签头
  # link_to_tab:  生成页签头的每一个页签
  # tab_page_for:  生成页签的页
  #
  # 需要引用 edit_tabs.js / edit_tabs.css
  #
  # # *Examples*
  #
  # 生成页签头
  #  <% tab_control_for do %>
  #     <%= link_to_tab 'tab1',:current=>true %>
  #     <%= link_to_tab 'tab2'%>
  #  <% end %>
  #
  # 生成每一个页签页
  #  <% tab_page_for 'tab1',:current=>true do %>
  #    <div>this is tab1</div>
  #  <% end %>
  #
  #  <% tab_page_for 'tab2' do %>
  #    <div>this is tab2</div>
  #  <% end %>
  def tab_control_for(&block)
    raise ArgumentError, "Missing block" unless block_given?
    concat(
      %{
    <div id="titlebar"><table cellpadding="0" cellspacing="0" border="0" id="volumebartable"><tr>
      },block.binding)
    concat(capture(&block),block.binding)
    concat('<td class="volumetitle"><div class="titlewrap">&nbsp;&nbsp;</div></td></tr></table></div>',block.binding)
  end

  # 生成页签头的每一个页签
  #  <% tab_control_for do %>
  #     <%= link_to_tab 'tab1',:current=>true %>
  #     <%= link_to_tab 'tab2'%>
  #  <% end %>
  def link_to_tab(name, options={})
    <<-Text
      <td class="volumetabspace">&nbsp;</td>
      <td id="edit_content_#{name}_link" class="volumetab #{'current_edit_tab' if options[:current]}"><nobr>
      #{link_to_function name,"EditTabs.select('edit_content_#{name}_link', 'edit_content_#{name}_tab');" }
      </nobr></td>
    Text
  end

  # 生成每一个页签页
  #  <% tab_page_forr 'tab1',:current=>true do %>
  #    <div>this is tab1</div>
  #  <% end %>
  #
  #  <% tab_page_for 'tab2' do %>
  #    <div>this is tab2</div>
  #  <% end %>
  #
  #  <% tab_page_for 'tab1',:current=>true %>
  def tab_page_for(name,options={},&block)
    raise ArgumentError, "Missing block" unless block_given?
    concat(
      %{
    <div class='edit_tab#{" visible_edit_tab" if options[:current]}' id='edit_content_#{name}_tab' style='#{"display : none;" unless options[:current]}'>
      },block.binding)
    concat(capture(&block),block.binding)
    concat('</div>',block.binding)
  end
end
