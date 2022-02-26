<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form @submit.prevent action='/api/v1/menu' accept-charset="UTF-8" method='patch'>
        <div class='upper_menu_content'>
          <p>MenuName :</p> 
          <input class="menu_name" type="text" name="menu[material]" id="menu_material" v-model="menu.material">
        </div>
        <div class='input_form' id="item_form" />
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
          <input @click="updateMenus" type="submit" name="commit" value="メニュー更新" class="btn" data-disable-with="メニュー更新">
          <router-link class="btn" to="/menus">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import menuItem from './edit_item.vue'
import backGround from '../../../service/background.service';
export default {
  data() {
    return {
      menu: {
        material: "",
        names: [],
        masses: [],
        total_protain: "",
        total_fat: "",
        total_carbohydrate: ""
      },
      updateMenu: false,
      protain: [],
      fat: [],
      carbo: [],
      total: ""
    };
  },
  components: { menuItem },
  beforeCreate() {
    backGround.getEditMenusBoard(this.$route.params['menuId'])
    .then( res => {
      this.menu.material = res.data.material
      res.data.names.forEach( elem => { this.menu.names.push(Number(elem)) })
      res.data.masses.forEach( melem => { this.menu.masses.push(Number(melem)) })
      this.menu.total_protain = res.data.total_protain
      this.menu.total_fat = res.data.total_fat
      this.menu.total_carbohydrate = res.data.total_carbohydrate
      console.log(res.data)
    });
  },
  beforeUpdate(){
    if(this.updateMenu == false){
      let num = this.menu.names.length;
      for(let i = 0; i < num; i++){
        let food_index = this.menu.names[i]
        let mass = this.menu.masses[i]
        this.updateItem(food_index, mass)
      }
      this.updateMenu = true
    }
  },
  methods: {
    updateMenus() {
      axios
      .patch("api/v1/menu/:menuId", { menu: this.data })
      .then( res => {
        if (res.data != 'not update') {
          this.$router.push({ name: "menus" });
          this.flashMessage.success({
            message: 'メニューを更新完了しました',
            time: 3000,
            class: 'notification__success'
          })
        }else{
          this.flashMessage.error({
            message: 'メニューを更新失敗です',
            time: 2000,
            class: 'notification__error'
          })
        }      
      })
      .catch( error => { console.log(error) });
    },
     updateItem(food_index, massValue) {
      let ComponentClass = Vue.extend(menuItem);
      let instance = new ComponentClass();
      let target = document.getElementById('item_form');

      instance.$on('plus-event', this.appendItem);
      instance.$on('reset-event', this.reset);
      instance.$on('calculate-event', this.result);
      instance.foodNumber = food_index;
      instance.mass = massValue;
      instance.displayMenu = true;
      instance.displayMass = true;
      instance.$mount();
      target.append(instance.$el);
    },
    appendItem() {
      let ComponentClass = Vue.extend(menuItem);
      let instance = new ComponentClass();
      let target = document.getElementById('item_form');

      instance.$on('plus-event', this.appendItem);
      instance.$on('reset-event', this.reset);
      instance.$on('calculate-event', this.result);
      instance.displayMenu = true;
      instance.$mount();
      target.append(instance.$el);
    },
    reset() {
      let num = document.getElementById('item_form').childElementCount;
      let val = document.getElementsByClassName('mass');
      let foodVal = document.getElementsByClassName('select_value');
      this.menu.masses = [];
      this.menu.names = [];
      
      for(let i = 0; i < num; i++) {
        if (foodVal[i].innerHTML == 0) { continue; }
        this.menu.names.push(parseFloat(foodVal[i].innerHTML));
        this.menu.masses.push(parseFloat(val[i].value));
      }
    },
    result() {
      let num = document.getElementById('item_form').childElementCount;
      let showProtain = document.getElementsByClassName('input_form__column__box__protain');
      let showFat = document.getElementsByClassName('input_form__column__box__fat');
      let showCarbo = document.getElementsByClassName('input_form__column__box__carbohydrate');

      this.protain = [];
      this.fat = [];
      this.carbo = [];

      for(let i = 0; i < num; i++) {
        if (showProtain[i] == undefined ) { continue; }
        this.protain.push(parseFloat(showProtain[i].children[1].children[0].innerHTML))
        this.fat.push(parseFloat(showFat[i].children[1].children[0].innerHTML))
        this.carbo.push(parseFloat(showCarbo[i].children[1].children[0].innerHTML))
        if(i == 2){ console.log(showProtain[2].children[1].children[0].outerText) }
      }

      this.menu.total_protain = Math.round(this.protain.reduce((num, elem) => num += elem, 0))
      this.menu.total_fat = Math.round(this.fat.reduce((num, elem) => num += elem, 0))
      this.menu.total_carbohydrate = Math.round(this.carbo.reduce((num, elem) => num += elem, 0))
      this.total = Math.round(this.menu.total_protain + this.menu.total_fat + this.menu.total_carbohydrate)
    }
  }
}
</script>
