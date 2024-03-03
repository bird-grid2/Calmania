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
    <div class='graph_wrapper'>
      <div class='graph_upper'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${gon.userId}_1.png">` }}
        </div>
        <div class="right_graph">
          {{ `<img src="/assets/test_${gon.userId}_2.png">` }}
        </div>
      </div>
      <div class='graph_bottom'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${gon.userId}_3.png">` }}
        </div>
        <div class='right_graph'>
          {{ `<img src="/assets/test_${gon.userId}_4.png">` }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { SendService } from '../service/send.service';

export default {
  data: {
    iconStyle: {
      display: 'block',
      width: '100%',
      color: 'white',
      fontSize: '3.5rem',
      marginBottom: '5%'
    }
  },
  methods: {
    sendInstance(){
      return new SendService()
    },
    getId() {
      return JSON.parse(sessionStorage.getItem('user')).user.id
    },
    logout() {
      const data = JSON.parse(sessionStorage.getItem('user'));

      this.sendInstance.signOut(data.user.token).then((res)=> {
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
    }
  }
}
</script>
