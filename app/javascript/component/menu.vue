<template>
  <div class="wrapper">
    <div class='side-management'>
        <router-link to='/management'>
          <i class='fas fa-home'></i>
          <h6 class='pc'>Home</h6>
          <h6 class='sp'>Home</h6>
        </router-link>
        <span></span>
        <router-link to='new_menu_path'>
          <i class='fas fa-plus-circle'></i>
          <h6 class='pc'>Create<br>menus</h6>
          <h6 class='sp'>Create menus</h6>
        </router-link>
        <span></span>
        <router-link to='destroy_user_session_path'>
          <i class='fas fa-sign-out-alt'></i>
          <h6 class='pc'>Sign<br>out</h6>
          <h6 class='sp'>Sign out</h6>
        </router-link>
    </div>
    <div class='menus_wrapper'>
      <div class='upper-info'>
        <table>
          <tbody>
            <tr>
              <th class='table-icon'></th>
              <th class='table-title'>Menu</th>
              <th class='table-title'>総重量 [g]</th>
              <th class='table-title'>タンパク質 [kCal]</th>
              <th class='table-title'>脂質 [kCal]</th>
              <th class='table-title'>炭水化物 [kCal]</th>
            </tr>
            <% @menus.each do |menu| %>
              <tr>
                <td class='table-icon'>
                  = link_to "menus/#{menu.id}/edit" do
                    <i class='fas fa-edit'>::before</i>
                  <span></span>
                  = link_to "menus/#{menu.id}", data: { confirm: "本当に削除しますか?" }, method: :delete do
                    <i class='fas fa-trash-alt'>::before</i>
                </td>
                <td class='table-item'>
                  <%= menu.material %>
                </td>
                <td class='table-item'>
                  <%= menu.masses.sum{ |num| num.to_i } %>
                </td>
                <td class='table-item'>
                  <%= menu.total_protain %>
                </td>
                <td class='table-item'>
                  <%= menu.total_fat %>
                </td>
                <td class='table-item'>
                  <%= menu.total_carbohydrate %>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        <%= form_with url: search_menus_path, method: :get, class: 'search-box', local: true do |f| %>
          <%= f.text_field :keyword, placeholder: 'メニューを入力して下さい', class: 'search-input' %>
      </div>
    </div>
  </div>
</template>