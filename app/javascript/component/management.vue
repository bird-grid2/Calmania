<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link to='/graph'>
        <font-awesome-icon :icon="['far', 'chart-bar']" :style="iconStyle" />
        <h6 class='pc'>Show<br>graphs</h6>
        <h6 class='sp'>Show graphs</h6>
      </router-link>
      <span />
      <router-link :to="{ name: 'logs', params: { userId: getId() }}">
        <font-awesome-icon :icon="['fas', 'file-alt']" :style="iconStyle" />
        <h6 class='pc'>Show<br>logs</h6>
        <h6 class='sp'>Show logs</h6>
      </router-link>
      <span />
      <router-link :to="{ name: 'editUser', params: { userId: getId() }}">
       <font-awesome-icon :icon="['fas', 'edit']" :style="iconStyle" />
        <h6 class='pc'>Edit<br>profile</h6>
        <h6 class='sp'>Edit profile</h6>
      </router-link>
      <span />
      <a @click="logout">
        <font-awesome-icon :icon="['fas', 'sign-out-alt']" :style="iconStyle" />
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </a>
    </div>
    <div class='main_wrapper'>
      <div class='top-managements'>
        <div class='top-managements__left-contents'>
          <div class='top-managements__left-contents--title'>
            <h1>BMI</h1>         </div>
          <div class='top-managements__left-contents--value'>
            <h3>{{ viewDetail[0] }}</h3>
          </div>
          <div class='border-dashed'></div>
          <div class='top-managements__left-contents--title'>
            <h1>適正体重</h1>
          </div>
          <div class='top-managements__left-contents--value'>
            <h3>{{ viewDetail[1] }}</h3><p>[kg]</p>
          </div>
        </div>
        <div class='top-managements__right-contents'>
          <div class='top-managements__right-contents-title'>
            <h1>体重</h1>
          </div>
          <div class='top-managements__right-contents--value'>
            <h3>{{ viewDetail[2] }}</h3><p>[kg]</p>
          </div>
          <div class='border-dashed'></div>
          <div class='top-managements__right-contents-title'>
            <h1>体脂肪率</h1>
          </div>
          <div class='top-managements__right-contents--value'>
            <h3>{{ viewDetail[3] }}</h3><p>[%]</p>
          </div>
        </div>
      </div>
      <div class='middle-managements'>
        <div class='middle-managements--main-title'>
          <div class='main-title'>
            <h2>摂取カロリー</h2>
          </div>
          <div class='total-value'>
            <h3>{{ viewDetail[4] }}</h3><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>たんぱく質摂取量</h4>
          </div>
          <div class='value'>
            <h6>{{ viewDetail[5] }}</h6><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>脂質摂取量</h4>
          </div>
          <div class='value'>
            <h6>{{ viewDetail[6] }}</h6><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>炭水化物摂取量</h4>
          </div>
          <div class='value'>
            <h6>{{ viewDetail[7] }}</h6><p>[kCal]</p>
          </div>
        </div>
      </div>
      <div class='bottom-managements'>
        <div class='upper-info'>
          <table>
            <tbody>
              <tr>
                <th class='table-title'>記録日</th>
                <th class='table-title'>体重 [kg]</th>
                <th class='table-title'>体脂肪率 [%]</th>
                <th class='table-title'>総カロリー [kCal]</th>
                <th class='table-title'>コメント</th>
              </tr>
              <tr v-for="log in logs" :key="log.id">
                <td class='table-item'>
                  {{ log.date }}
                </td>
                <td class='table-item'>
                  {{ log.weight }}
                </td>
                <td class='table-item'>
                  {{ log.bfp }}
                </td>
                <td class='table-item'>
                  {{ log.total_cal }}
                </td>
                <td class='table-item'>
                  {{ log.description }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>   
  </div>
</template>

<script>
import { BackgroundService } from '../service/background.service';
import { SendService, sendService } from '../service/send.service';
export default {
  data() {
    return {
      managements: {
        bmi: "",
        idealWeight: "",
        weight: "",
        bfp: "",
        totalCal: "",
        protain: "",
        fat: "",
        carboHydrate: ""
      },
      logs: [],
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
    const instance = new BackgroundService()
    instance.getManagementsBoard()
    .then(res => { 
      this.managements = res.data.managements
      this.logs = res.data.logs
    })
    .catch( error => { console.log(error)})
  },
  methods: {
    getId() {
      return JSON.parse(sessionStorage.getItem('user')).id
    },
    logout() {
      const data = JSON.parse(sessionStorage.getItem('user'));
      const instance = new SendService();

      instance.signOut(data.user.token).then((res)=> {
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
  },
  computed: {
    viewDetail: function() {
      let target = [ 
        this.managements.bmi,
        this.managements.idealWeight,
        this.managements.weight,
        this.managements.bfp,
        this.managements.totalCal,
        this.managements.protain,
        this.managements.fat,
        this.managements.carboHydrate
      ];

      let res = target.map(elem => elem == "" ? '---' : elem);
      return res
    }
  }
}
</script>