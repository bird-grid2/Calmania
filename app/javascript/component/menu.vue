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
            <tr v-show="searchView" v-for="(menu, index) in menus" :key="menu.id">
              <td class='table-icon'>
                <router-link :to="{name: 'menuEdit', params: { menuId: menu.id }}">
                  <font-awesome-icon :icon="['fas', 'edit']" class="fas" :style="iconStyle"></font-awesome-icon>
                </router-link>
                <span />
                <button @click="deleteAction(menu.id, menu)" > <!-- data-confirm="本当に削除しますか?" -->
                  <font-awesome-icon :icon="['fas', 'trash-alt']" class="fas" :style="iconStyle"></font-awesome-icon>
                </button>
              </td>
              <td class='table-item'>
                {{menu.material}}
              </td>
              <td class='table-item'>
                {{total(index)}}
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
            <div v-show="!searchView" class="name">一致するメニューがありません</div>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        <form @submit.prevent class="search-box" action="/menus/search" accept-charset="UTF-8" method="get">
          <input placeholder="メニューを入力して下さい" class="search-input" type="text" name="keyword" id="keyword" @keyup="incrementalSearch">
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { SendService } from '../service/send.service'
import { BackgroundService } from '../service/background.service'
export default {
  data() {
    return {
      menus: [],
      iconStyle: {
        display: 'block',
        width: '100%',
        color: 'white',
        fontSize: '2.5rem',
        marginBottom: '5%'
      },
      searchView: true
    }
  },
  mounted() {
    const instance = new BackgroundService()
    instance.getMenusBoard()
    .then( res => {
      res.data.forEach( (elem) =>{
        this.menus.push(elem);
      })
    })
    .catch( error => { console.log(error) })
  },
  methods: {
    sendInstance(){
      return new SendService()
    },
    getId() {
      return JSON.parse(sessionStorage.getItem('user')).id
    },
    logout() {
      const data = JSON.parse(sessionStorage.getItem('user'));

      this.sendInstance().signOut(data.user.token).then((res)=> {
        if(res.status === 200){
          sessionStorage.clear();
          this.$router.push({name: 'index'})
          location.reload();
        } else {
          this.flashMessage.error({
            message: 'ログアウトが失敗しました',
            time: 2000,
            class: 'notification__error'
          });
        } 
      }).catch((error)=>{ console.log(error); });
    },
    total(mass) {
      let res = Math.round(this.menus[mass].masses.reduce((sum, menu) => sum += Number(menu), 0));
      return res
    },
    incrementalSearch() {
      let input = document.getElementById('keyword').value
      
      this.sendInstance().postMenuSearch(input)
      .then( res => {
        if(res.data == null) {
          this.searchView = false;
          if(input == null) {
            this.menus = [];
            res.data.forEach( elem => {
              this.menus.push(elem);
            })
          }
        }else{
          this.searchView = true;
          this.menus = [];
          res.data.forEach( elem => {
            this.menus.push(elem);
          })
        }
      })
      .catch( error => { console.log(error) });
    },
    deleteAction(index, params) {
      this.sendInstance().deleteMenu(index, params)
      .then( res => {
        if (res.data != 'not delete menu') {
          this.$router.push({ name: "menus", force: true});
          this.flashMessage.success({
            message: 'メニューを削除しました',
            time: 3000,
            class: 'notification__success'
          })
        }else{
          this.flashMessage.error({
            message: 'メニューを削除失敗しました',
            time: 2000,
            class: 'notification__error'
          })
        }
      })
      .catch( error => { console.log(error); });
    }
  }
}
</script>
