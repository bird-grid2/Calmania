<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link to='/graph'>
        <i class='far fa-chart-bar'></i>
        <h6 class='pc'>Show<br>graphs</h6>
        <h6 class='sp'>Show graphs</h6>
      </router-link>
      <span></span>
      <router-link to='/log'>
        <i class='fas fa-file-alt'></i>
        <h6 class='pc'>Create<br>logs</h6>
        <h6 class='sp'>Create logs</h6>
      </router-link>
      <span></span>
      <router-link to='/log/:id/edit'>
        <i class='fas fa-edit'></i>
        <h6 class='pc'>Edit<br>profile</h6>
        <h6 class='sp'>Edit profile</h6>
      </router-link>
      <span></span>
      <router-link to='/'>
        <i class='fas fa-sign-out-alt'></i>
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </router-link>
    </div>
    <div class='main_wrapper'>
      <div class='top-managements'>
        <div class='top-managements__left-contents'>
          <div class='top-managements__left-contents--title'>
            <h1>BMI</h1>
          </div>
          <div class='top-managements__left-contents--value'>
            <h3>"#{@body_mass_index.present? ? @body_mass_index : '---'}"</h3>
          </div>
          <div class='border-dashed'></div>
          <div class='top-managements__left-contents--title'>
            <h1>適正体重</h1>
          </div>
          <div class='top-managements__left-contents--value'>
            <h3>#{@weight.present? ? @weight : '---'}</h3><p>[kg]</p>
          </div>
        </div>
        <div class='top-managements__right-contents'>
          <div class='top-managements__right-contents-title'>
            <h1>体重</h1>
          </div>
          <div class='top-managements__right-contents--value'>
            <h3>#{@today_weight.present? ? @today_weight : '---'}</h3><p>[kg]</p>
          </div>
          <div class='border-dashed'></div>
          <div class='top-managements__right-contents-title'>
            <h1>体脂肪率</h1>
          </div>
          <div class='top-managements__right-contents--value'>
            <h3>#{@today_bfp.present? ? @today_bfp : '---'}</h3><p>[%]</p>
          </div>
        </div>
      </div>
      <div class='middle-managements'>
        <div class='middle-managements--main-title'>
          <div class='main-title'>
            <h2>摂取カロリー</h2>
          </div>
          <div class='total-value'>
            <h3>#{@today_cal}</h3><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>たんぱく質摂取量</h4>
          </div>
          <div class='value'>
            <h6>#{@today_protain}</h6><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>脂質摂取量</h4>
          </div>
          <div class='value'>
            <h6>#{@today_fat}</h6><p>[kCal]</p>
          </div>
        </div>
        <div class='border-line'></div>
        <div class='middle-managements--title'>
          <div class='titles'>
            <h4>炭水化物摂取量</h4>
          </div>
          <div class='value'>
            <h6>#{@today_carb}</h6><p>[kCal]</p>
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
import axios from 'axios';
export default {
  data() {
    return {
      logs: []
    }
  },
  created() {
    axios
    .get('/api/v1/managements/index.json')
    .then(responce => { this.logs = responce.data })
  }
}
</script>