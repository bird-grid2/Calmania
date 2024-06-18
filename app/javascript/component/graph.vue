<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link :to="{ name: 'management', params: { userId: getId() }}">
        <font-awesome-icon :icon="['fas', 'home']" :style="iconStyle" />
        <h6 class='pc'>Home</h6>
        <h6 class='sp'>Home</h6>
      </router-link>
      <a @click="logout">
        <font-awesome-icon :icon="['fas', 'sign-out-alt']" :style="iconStyle" />
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </a>
    </div>
    <div v-if="this.checkFlg" class='graph_wrapper'>
      <div class='graph_upper'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${this.getId()}_1.png">` }}
        </div>
        <div class="right_graph">
          {{ `<img src="/assets/test_${this.getId()}_2.png">` }}
        </div>
      </div>
      <div class='graph_bottom'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${this.getId()}_3.png">` }}
        </div>
        <div class='right_graph'>
          {{ `<img src="/assets/test_${this.getId()}_4.png">` }}
        </div>
      </div>
    </div>
    <div v-else class='graph_warpper'>
        <div calss=" no_graph">
          <h1>グラフがありません</h1>
        </div>
    </div>
  </div>
</template>

<script>
import { SendService } from '../service/send.service';
import { BackgroundService } from '../service/background.service';
import axios from 'axios';
export default {
  data() {
    return {
      checkFlg: false,
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
    this.getInstance().getGraphsBoard()
    .then(response => {
      console.log('Response:', response);
    })
    //this.checkFlg = this.checkPath();
  },
  methods: {
    sendInstance(){
      return new SendService();
    },
    getInstance(){
      return new BackgroundService();
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
          this.$flashMessage.show({
            type: 'error',
            title: 'ログアウトが失敗しました',
            time: 2000,
            class: 'notification__error'
          });
        } 
      }).catch((error)=>{ console.log(error); });
    },
    checkPath() {
        const flg = this.getInstance().getGraphsBoard().then((res)=> {
          return res.data.imagePath;
        });

        return flg;
    }
  }
}
</script>
