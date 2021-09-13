<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form @submit.prevent action='/api/v1/menus' id="menu" accept-charset="UTF-8" method='post'>
        <div class='upper_menu_content'>
          <p>MenuName :</p> 
          <input class="menu_name" type="text" name="menu[material]" id="menu_material" v-model="menu.material">
        </div>
        <div class='input_form' id="item_form">
          <menu-item id="menu_item" @plus-event="appendItem" @reset-event="reset" @calculate-event="result" />
        </div>
        <div class='calculate_box'>
          <div class='calculate_box__title'>
            <h2>タンパク質 合計</h2>
            <h2>脂質 合計</h2>
            <h2>炭水化物 合計</h2>
            <h2>総カロリー</h2>
          </div>
          <div class='calculate_box__result'>
            <div class='calculate_box__result--protain'>
              <h3>{{ this.menu.total_protain == "" ? '---' : this.menu.total_protain }}</h3><p>kCal</p>
            </div>
            <div class='calculate_box__result--fat'>
              <h3>{{ this.menu.total_fat == "" ? '---' : this.menu.total_fat }}</h3><p>kCal</p>
            </div>
            <div class='calculate_box__result--carbohydrate'>
              <h3>{{ this.menu.total_carbohydrate == "" ? '---' : this.menu.total_carbohydrate }}</h3><p>kCal</p>
            </div>
            <div class='calculate_box__result--total'>
              <h3>{{ this.total == "" ? '---' : this.total }}</h3><p>kCal</p>
            </div>
            <div class='calculate_box__result--form'></div>
          </div>
        </div>
        <div class='bottom_menu_content'>
          <input @click="createMenus" type="submit" name="commit" value="メニュー作成" class="btn" data-disable-with="メニュー作成">
          <router-link class="btn" to="/menus">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import MenuItem from './menu/menu_item.vue'
import sendService from '../service/send.service';
export default {
  data() {
    return {
      menu: {
        material: "",
        total_protain: "",
        total_fat: "",
        total_carbohydrate: "",
        names: [],
        masses: []
      },
      protain: [],
      fat: [],
      carbo: [],
      total: ""
    }
  },
  components: { MenuItem },
  methods: {
    createMenus() {
      sendService.postMenu(this.menu)
      .then( res => {
        if (res.data != 'not create menu') {
          this.$router.push({ name: "menus" });
          this.flashMessage.success({
            message: 'メニューを作成しました',
            time: 3000,
            class: 'notification__success'
          })
        }else{
          this.flashMessage.error({
            message: 'メニューを作成失敗しました',
            time: 2000,
            class: 'notification__error'
          })
        }
      })
      .catch( error => { console.log(error); });
    },
    appendItem() {
      let ComponentClass = Vue.extend(MenuItem);
      let instance = new ComponentClass();
      let target = document.getElementById('item_form')

      instance.$on('plus-event', this.appendItem)
      instance.$on('reset-event', this.reset)
      instance.$on('calculate-event', this.result)
      instance.displayMenu = true
      instance.$mount();
      target.append(instance.$el)
    },
    reset() {
      this.$nextTick(() => {
        let num = document.getElementById('item_form').childElementCount;
        let val = document.getElementsByClassName('mass');
        let foodVal = document.getElementsByClassName('select_value');
        this.menu.masses = [];
        this.menu.names = [];
        
        for(let i = 0; i < num; i++) {
          if (foodVal[i].innerHTML == "選択して下さい") { continue; }
          this.menu.names.push(Number(foodVal[i].innerHTML));
          if (val.length != foodVal.length && i == num -1) {
            this.menu.masses.push(parseFloat(val[(i - 1)].value));
          }else{
            this.menu.masses.push(parseFloat(val[i].value));
          }
        }
        this.result()
      })
    },
    result() {
      this.$nextTick(() => {
        let num = document.getElementById('item_form').childElementCount;
        let showProtain = document.getElementsByClassName('input_form__column__box__protain');
        let showFat = document.getElementsByClassName('input_form__column__box__fat')
        let showCarbo = document.getElementsByClassName('input_form__column__box__carbohydrate')

        this.protain = [];
        this.fat = [];
        this.carbo = [];

        for(let i = 0; i < num; i++) {
          if (showProtain[i] == undefined ) { continue; }
          this.protain.push(parseFloat(showProtain[i].children[1].children[0].innerHTML))
          this.fat.push(parseFloat(showFat[i].children[1].children[0].innerHTML))
          this.carbo.push(parseFloat(showCarbo[i].children[1].children[0].innerHTML))
        }

        this.menu.total_protain = Math.round(this.protain.reduce((num, elem) => num += elem, 0))
        this.menu.total_fat = Math.round(this.fat.reduce((num, elem) => num += elem, 0))
        this.menu.total_carbohydrate = Math.round(this.carbo.reduce((num, elem) => num += elem, 0))
        this.total = Math.round(this.menu.total_protain + this.menu.total_fat + this.menu.total_carbohydrate)
      })
    }
  }
}
</script>
