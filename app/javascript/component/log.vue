<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link :to="{ name: 'management', params: { userId: getId() }}">
        <font-awesome-icon :icon="['fas', 'home']" :style="iconStyle" />
        <h6 class='pc'>Home</h6>
        <h6 class='sp'>Home</h6>
      </router-link>
      <span></span>
      <router-link to='/menus'>
        <font-awesome-icon :icon="['fas', 'th-list']" :style="iconStyle" />
        <h6 class='pc'>Shows<br>menus</h6>
        <h6 class='sp'>Shows menus</h6>
      </router-link>
      <span></span>
      <router-link to="/log">
        <font-awesome-icon :icon="['fas', 'plus-circle']" :style="iconStyle" />
        <h6 class='pc'>Create<br>logs</h6>
        <h6 class='sp'>Create logs</h6>
      </router-link>
      <span></span>
      <a @click="logout">
        <font-awesome-icon :icon="['fas', 'sign-out-alt']" :style="iconStyle" />
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </a>
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
            <tr v-show="searchView" v-for="log in logs" :key="log.id">
              <td class='table-icon'>
                <router-link :to="{ name: 'editLog', params: { logId: log.id }}">
                  <font-awesome-icon :icon="['fas', 'edit']" :style="iconStyle" />
                </router-link>
                <span></span>
                <button @click="deleteAction(log.id, log)">
                  <font-awesome-icon :icon="['fas', 'trash-alt']" :style="iconStyle" />
                </button>
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
                {{ log.total_cal }}
              </td>
              <td class='table-item'>
                {{ log.description }}
              </td>
            </tr>
            <div v-show="!searchView" class="name">一致する記録がありません</div>
          </tbody>
        </table>
      </div>
      <div class='bottom-info'>
        <form @submit.prevent class="search-date" action="/logs/dsearch" accept-charset="UTF-8" method="get">
          <p>記録日検索：</p><input class="search-date-input" type="date" name="keyword2" id="keyword2" @change="incrementaldSearch">
        </form>
        <form @submit.prevent class="search-box" action="/logs/search" accept-charset="UTF-8" method="get">
          <p>コメント検索：</p><input placeholder="コメントを入力して下さい" class="search-input" type="text" name="keyword" id="keyword" @keyup="incrementalSearch" >
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import BackGround from '../service/background.service';
import sendService from '../service/send.service';
export default {
  data() {
    return {
      logs: [],
      searchView: true,
      iconStyle: {
        display: 'block',
        width: '100%',
        color: 'white',
        fontSize: '2.5rem',
        marginBottom: '5%'
      }
    }
  },
  mounted() {
    BackGround.getLogsBoard()
    .then( res => {
      if (res.data.length == 1) {
        this.logs.push(res.data);
      }else{
        res.data.forEach( elem => {
          this.logs.push(elem);
        })
      }
    })
    .catch( error => { console.log(error) });
  },
  methods: {
    getId() {
      const responce = JSON.parse(sessionStorage.getItem('user')).user.id;
      return responce
    },
    logout() {
      sessionStorage.clear();
      this.$router.push({name: 'index'})
    },
    incrementaldSearch() {
      let input =  document.getElementById('keyword2').value
      
      sendService.postLogdSearch(input)
      .then( res => {
        if(res.data == null) {
          this.searchView = false;
          if(input == null) {
            this.logs = [];
            res.data.forEach( elem => {
              this.logs.push(elem);
            })
          }
        }else{
          this.searchView = true;
          this.logs = [];
          res.data.forEach( elem => {
            this.logs.push(elem);
          })
        }
      })
      .catch( error => { console.log(error) });
    },
    incrementalSearch() {
      let input = document.getElementById('keyword').value
      
      sendService.postLogSearch(input)
      .then( res => {
        if(res.data == null) {
          this.searchView = false;
          if(input == null) {
            this.logs = [];
            res.data.forEach( elem => {
              this.logs.push(elem);
            })
          }
        }else{
          this.searchView = true;
          this.logs = [];
          res.data.forEach( elem => {
            this.logs.push(elem);
          })
        }
      })
      .catch( error => { console.log(error) });
    },
    deleteAction(index, params){
      sendService.deleteLog(index, params)
      .then( res => {
        if (res.data != 'not delete log') {
          this.$router.push({ name: "logs", params: { userId: this.getId } });
          this.flashMessage.success({
            message: 'ログを削除しました',
            time: 3000,
            class: 'notification__success'
          })
        }else{
          this.flashMessage.error({
            message: 'ログを削除失敗しました',
            time: 2000,
            class: 'notification__error'
          })
        }
      })
      .catch( error => { console.log(error) });
    }
  }
}
</script>