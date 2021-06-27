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
            <tr v-for="log in logs" :key="log.id">
              <td class='table-icon'>
                <router-link to="logs/#{log.id}/edit">
                  <i class='fas fa-edit'></i>
                </router-link>
                <span></span>
                <router-link to="logs/#{log.id}" data-confirm="本当に削除しますか?" rel="nofollow" data-method="delete">
                  <i class='fas fa-trash-alt'></i>
                </router-link>
              </td>
              <td class='table-item'>
                {{log.date}}
              </td>
              <td class='table-item'>
                {{log.weight}}
              </td>
              <td class='table-item'>
                {{log.bfp}}
              </td>
              <td class='table-item'>
                {{log.total_cal}}
              </td>
              <td class='table-item'>
                {{ log.description }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        <form class="search-date" action="/logs/dsearch" accept-charset="UTF-8" method="get">
          <p>記録日検索：</p><input class="search-date-input" type="date" name="keyword2" id="keyword2">
        </form>
        <form class="search-box" action="/logs/search" accept-charset="UTF-8" method="get">
          <p>コメント検索：</p><input placeholder="コメントを入力して下さい" class="search-input" type="text" name="keyword" id="keyword">
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      logs: []
    }
  },
  created() {
    axios
    .get('api/v1/logs/index.json')
    .then( responce => (this.logs = responce.data));
  }
}
</script>