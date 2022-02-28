<template>
  <div class='wrapper'>
    <div class='logs_create_wrapper'>
      <form id="logs" action="/logs" accept-charset="UTF-8" method="post">
        <div class='input-form'>
          <div class='upper_content'>
            <div class='input_column'>
              <p>記録日 :</p>
              <input class="input_box" type="date" name="log[date]" id="log_date" v-model="logs.date">
            </div>
            <div class='input_column'>
              <p>体重 [kg] :</p> 
              <input step="0.1" class="input_box" type="number" name="log[weight]" id="log_weight" v-model="logs.weight">
            </div>
            <div class='input_column'>
              <p>体脂肪率 [%] :</p> 
              <input step="0.1" class="input_box" type="number" name="log[bfp]" id="log_bfp" v-model="logs.bfp">
            </div>
          </div>
          <div class='comment_box'>
            <p>コメント :</p> 
            <textarea class="comment" name="log[description]" id="log_description" v-model="logs.description"></textarea>
          </div>
          <div class='menu_columns'>
            <div class='menu_columns__col'>
              <div class='menu_columns__col__label'>
                <i class='fas fa-plus-circle icon' id='menu-plus'></i>
              </div>
              <div class='input_name'>
                <select name="log[menu_numbers][]" id="log_menu_numbers"></select>
              </div>
              <div class='input_name_box_0#box'></div>
            </div>
          </div>
        </div>
        <div class='bottom_content'>
          <div class='show_calory'>
            <div class='show_calory--protain'>
              <h2>タンパク質 合計</h2>
              <div class='label'>
                <h3>{{ totalProtain == [] ? '----' : protainShow }}</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--fat'>
              <h2>脂質 合計</h2>
              <div class='label'>
                <h3>{{ totalFat == [] ? '----' : fatShow }}</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--carbohydrate'>
              <h2>炭水化物 合計</h2>
              <div class='label'>
                <h3>{{ totalCarbohydrate == [] ? '----' : carboShow }}</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--total'>
              <h2>総カロリー</h2>
              <div class='label'>
                <h3>{{ logs.total_cal == "" ? "----" : logs.total_cal }}</h3>
                <p>[kCal]</p>
              </div>
            </div>
          </div>
          <input @click="creatLogs" type="submit" name="commit" value="ログ作成" class="btn" data-disable-with="ログ作成">
          <router-link class="btn" to="/logs">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import backGround from '../../../service/background.service';
import logItem from '../log_item.vue';
export default {
  data() {
    return {
      logs: { 
        date: "",
        weight: "",
        bfp: "",
        description: "",
        total_cal: "",
        menu_numbers: []
      },
      iconStyle: {
        display: 'block',
        width: '100%',
        color: 'white',
        fontSize: '3.5rem',
        marginBottom: '5%'
      },
      totalProtain: [],
      totalFat: [],
      totalCarbohydrate: []
    }
  },
  beforeCreate() {
    let self = this
    loadLogs(this.$route.params['logId']);

    async function loadLogs(args){
      let bgData = await backGround.getLogsBoard(args).catch(err => console.log(err));
      self.logs.date = bgData.data.logs.date;
      self.logs.weight = bgData.data.logs.weight;
      self.logs.bfp = bgData.data.logs.bfp;
      self.logs.description = bgData.data.logs.description;
      bgData.data.logs.menu_numbers.forEach(elem => { self.logs.menu_numbers.push(Number(elem)); })
    }
    console.log(this.logs)
  },
  created() {

  },
  methods: {
    createLogs() {
      axios
      .post("api/v1/Logs/update", { log: this.logs })
      .then( (response)=> { this.$router.push({ path: "/log" }); }, (error)=> { console.log(error); });
    }
  }
}
</script>
