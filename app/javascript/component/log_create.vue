<template>
  <div class='wrapper'>
    <div class='logs_create_wrapper'>
      <form @submit.prevent id="logs" action="/logs" accept-charset="UTF-8" method="post">
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
            <textarea class="comment" name="log[description]" id="log_description" v-model="logs.description" />
          </div>
          <div class='menu_columns' id="target">
            <log-item @plus-event="appendItem" @reset-event="updateItem" @calculate-event="updateItem" />
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
                <h3>{{ total == "0" ? "----" : total }}</h3>
                <p>[kCal]</p>
              </div>
            </div>
          </div>
          <input @click="createLogs" type="submit" name="commit" value="ログ作成" class="btn" data-disable-with="ログ作成">
          <router-link class="btn" to="/logs">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import sendService from '../service/send.service';
import logItem from './log/log_item.vue';
export default {
  data() {
    return {
      logs: { 
        date: "",
        weight: "",
        bfp: "",
        description: "",
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
      totalCarbohydrate: [],
      total: "0"
    }
  },
  components: { logItem },
  methods: {
    createLogs() {
      sendService.postLog(this.logs)
      .then( res => {
        if (res.data != 'not create log') {
          this.$router.push({ name: "logs" });
          this.flashMessage.success({
            message: 'ログを作成しました',
            time: 3000,
            class: 'notification__success'
          })
        }else{
          this.flashMessage.error({
            message: 'ログを作成失敗しました',
            time: 2000,
            class: 'notification__error'
          })
        }
      })
      .catch( error => { console.log(error) });
    },
    appendItem() {
      let ComponentClass = Vue.extend(logItem);
      let instance = new ComponentClass();
      let target = document.getElementById('target')

      instance.$on('plus-event', this.appendItem)
      instance.$on('reset-event', this.updateItem)
      instance.$on('calculate-event', this.updateItem)
      instance.minus = true
      instance.$mount();
      target.append(instance.$el)
    },
    updateItem() {
      this.$nextTick(() => {
        let num = document.getElementById('target').childElementCount;
        let protain = document.getElementsByName('total_protain');
        let fat = document.getElementsByName('total_fat');
        let carbo = document.getElementsByName('total_carbohydrate');
        let index = document.getElementsByName('log[menu_numbers][]')
        this.totalProtain = [];
        this.totalFat = [];
        this.totalCarbohydrate = [];
        this.logs.menu_numbers = [];

        for(let i = 0; i < num;  i++) {
          this.totalProtain.push(Number(protain[i].innerText))
          this.totalFat.push(Number(fat[i].innerText))
          this.totalCarbohydrate.push(Number(carbo[i].innerText))
          if (index[i].options.selectedIndex == 0) { continue; }
          this.logs.menu_numbers.push(Number(index[i].options.selectedIndex))
        }

        let value_1 = this.protainShow;
        let value_2 = this.fatShow;
        let value_3 = this.carboShow;
        this.total = Math.round( value_1 + value_2 + value_3 );
      })
    }
  },
   computed: {
      protainShow: function() {
        return this.totalProtain.reduce( (sum, elem) => sum += elem, 0)
      },
      fatShow: function() {
        return this.totalFat.reduce( (sum, elem) => sum +=elem, 0)
      },
      carboShow: function() {
        return this.totalCarbohydrate.reduce( (sum, elem) => sum += elem, 0)
      }
    }
}
</script>
