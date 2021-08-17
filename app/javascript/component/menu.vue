<template>
  <div class="wrapper">
    <div class='side-management'>
      <router-link :to="{ name: 'management', params: { userId: getId() }}">
        <font-awesome-icon :icon="['fas', 'home']" :style="iconStyle" />
        <h6 class='pc'>Home</h6>
        <h6 class='sp'>Home</h6>
      </router-link>
      <span></span>
      <router-link to='/menu'>
        <font-awesome-icon :icon="['fas', 'plus-circle']" :style="iconStyle" />
        <h6 class='pc'>Create<br>menus</h6>
        <h6 class='sp'>Create menus</h6>
      </router-link>
      <span></span>
      <a @click="logout">
        <font-awesome-icon :icon="['fas', 'sign-out-alt']" :style="iconStyle" />
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </a>
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
            <tr v-for="menu in menus" :key="menu.id">
              <td class='table-icon'>
                <router-link :to="{name: 'menuEdit', params: { menuId: menu.id }}">
                  <font-awesome-icon :icon="['fas', 'edit']" class="fas"></font-awesome-icon>
                </router-link>
                <span />
                <router-link to="/menus/#{menu.id}"  data-confirm="本当に削除しますか?"  method="delete">
                  <font-awesome-icon :icon="['fas', 'trash-alt']" class="fas"></font-awesome-icon>
                </router-link>
              </td>
              <td class='table-item'>
                {{menu.material}}
              </td>
              <td class='table-item'>
                {{total( menu.id - 1 )}}
              </td>
              <td class='table-item'>
                {{menu.total_protain}}
              </td>
              <td class='table-item'>
                {{menu.total_fat}}
              </td>
              <td class='table-item'>
                {{menu.total_carbohydrate}}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        <form class="search-box" action="/menus/search" accept-charset="UTF-8" method="get">
          <input placeholder="メニューを入力して下さい" class="search-input" type="text" name="keyword" id="keyword">
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import BackgroundService from '../service/background.service'
export default {
  data() {
    return {
      menus: [],
      iconStyle: {
        display: 'block',
        width: '100%',
        color: 'white',
        fontSize: '3.5rem',
        marginBottom: '5%'
      }
    }
  },
  mounted() {
    BackgroundService.getMenusBoard()
    .then( res => {
      this.menus = res.data
    })
    .catch( error => { console.log(error) });
  },
  methods: {
    getId() {
      return JSON.parse(sessionStorage.getItem('user')).user.id
    },
    logout() {
      sessionStorage.clear();
      this.$router.push({name: 'index'})
    },
    total(mass) {
      let res = Math.round(this.menus[mass].masses.reduce((sum, menu) => sum += Number(menu), 0));
      return res
    }
  }
}
</script>
