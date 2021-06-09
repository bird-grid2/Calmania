<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link to='/manegement'>
        <i class='fas fa-home'></i>
        <h6 class='pc'>Home</h6>
        <h6 class='sp'>Home</h6>
      </router-link>
      <span></span>
      <router-link to='/menu'>
        <i class='fas fa-th-list'></i>
        <h6 class='pc'>Shows<br>menus</h6>
        <h6 class='sp'>Shows menus</h6>
      </router-link>
      <span></span>
      <router-link to='/log'>
        <i class='fas fa-plus-circle'></i>
        <h6 class='pc'>Create<br>logs</h6>
        <h6 class='sp'>Create logs</h6>
      </router-link>
      <span></span>
      <router-link to='/'>
        <i class='fas fa-sign-out-alt'></i>
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </router-link>
    </div>
    <div class='logs_wrapper'>
      <div class='upper-info'>
        <table>
          <tbody>
            <tr>
              <th class='table-icon'></th>
              <th class='table-title'>記録日</th>
              <th class='table-title'>体重 [kg]</th>
              <th class='table-title'>体脂肪率 [%]</th>
              <th class='table-title'>総カロリー [kCal]</th>
              <th class='table-title'>コメント</th>
            </tr>
            <template>@logs.each_with_index do |log|
              <tr>
                <td class='table-icon'>
                  <router-link to="logs/#{log.id}/edit">
                    <i class='fas fa-edit'></i>
                  </router-link>
                  <span></span>
                  <router-link>"logs/#{log.id}", data: { confirm: "本当に削除しますか?" }, method: :delete do
                    <i class='fas fa-trash-alt'></i>
                  </router-link>
                </td>
                <td class='table-item'>
                  = log.date
                </td>
                <td class='table-item'>
                  = log.weight
                </td>
                <td class='table-item'>
                  = log.bfp
                </td>
                <td class='table-item'>
                  = log.total_cal
                </td>
                <td class='table-item'>
                  = log.description
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        = form_with url: dsearch_logs_path, method: :get, class: 'search-date',local: true do |f|
          %p 記録日検索：
          = f.date_field :keyword2, class: 'search-date-input'
        = form_with url: search_logs_path, method: :get, class: 'search-box', local: true do |f|
          %p コメント検索：
          = f.text_field :keyword, placeholder: 'コメントを入力して下さい', class: 'search-input'
      </div>
    </div>
  </div>
</template>