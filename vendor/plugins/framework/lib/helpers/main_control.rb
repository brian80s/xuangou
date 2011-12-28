# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

module Bolide::Helpers::MainControl
  #
  # 需要 navbar.js / head.css / style.css
  #
  #  <% main_menu_control_for do %>
  #    <%= link_to_main_menu "业务处理",:url=>{:controller=>"default",:action=>"business"},:target=>"contents" %>
  #    <%= link_to_main_menu "查询",:url=>"default/list",:target=>"navbar" %>
  #    <%= link_to_main_menu "凭证报表",:controller=>"default",:action=>"business",:target=>"navbar" %>
  #    <%= link_to_main_menu "系统维护",:url=>{:controller=>"default",:action=>"list"},:target=>"contents" %>
  #    <%= link_to_main_menu "业务处理1" %>
  #  <%end%>
  def main_menu_control_for(&block)
    raise ArgumentError, "Missing block" unless block_given?
    concat(
      %{
      <table id="mt" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
        <td width="100%">&nbsp;</td>        
        <td>
        #{image_tag "loader.gif",:style=>"display:none;",:id=>"gc-loading" } 
        </td>
        <td>&nbsp;&nbsp;</td>    
      },block.binding)
    concat(capture(&block),block.binding)
    concat(
      %{
        <td>&nbsp;&nbsp;</td>
        </tr>
      </table>

      <table cellspacing="0" cellpadding="0" width="100%" align="center" border="0" class="st">
        <tr>
          <td height=2 align=right style="padding:0px; vertical-align:top">
            <div class="stur"></div>
          </td>
        </tr>
      </table>
      },block.binding)
  end
  #
  #生成主菜单项
  #
  # ===例如
  # <%= link_to_main_menu "System",
  #               :url=>{:controller=>"default",:action=>"business"},
  #               :target=>"contents" %>
  #
  # <%= link_to_main_menu "System",
  #               :url=>{:controller=>"default",:action=>"business"} %>
  #
  # <%= link_to_main_menu "System" %>
  #
  def link_to_main_menu(name,options={})
    function="Navbars.select('navbar_#{name}_link');switchDisplay('gc-loading');"
    <<-Text
        <th id="navbar_#{name}_link" class="selected" >
        <div class="style1 " style="height: 4px;">
          <div class="style2" style="height: 4px;"><div class="tc3"></div></div>
        </div>
        <div class="style3">
        #{link_to_remote name,
            :url => "#{url_for(options)}",
            :loading => "switchDisplay('gc-loading')",
            :complete => "#{function}" }
        </div>
      </th>
      <td>&nbsp;&nbsp;</td>
    Text
  end
  
  def link_to_remote_main_menu(name,options={})
    function="Navbars.select('navbar_#{name}_link');"
    #如果有url那么绑定url
    function<<"window.open('#{url_for(options[:url])}','#{options[:target] ? options[:target] :'_self' }');"  if options[:url]
    <<-Text
        <th id="navbar_#{name}_link" class="selected" >
        <div class="style1 " style="height: 4px;">
          <div class="style2" style="height: 4px;"><div class="tc3"></div></div>
        </div>
        <div class="style3">
        #{link_to_function name,"#{function}" }
        </div>
      </th>
      <td>&nbsp;&nbsp;</td>
    Text
  end
end
