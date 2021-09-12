<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form @submit.prevent action='/api/v1/menu' accept-charset="UTF-8" method='patch'>
        <div class='upper_menu_content'>
          <p>MenuName :</p> 
          <input class="menu_name" type="text" name="menu[material]" id="menu_material" v-model="menu.material">
        </div>
        <div class='input_form' id="item_form">
          <menu-item @plus-event="appendItem" @reset-event="reset"  @calculate-event="result($event)" />
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
              <p>--- kCal</p>
            </div>
            <div class='calculate_box__result--fat'>
              <p>--- kCal</p>
            </div>
            <div class='calculate_box__result--carbohydrate'>
              <p>--- kCal</p>
            </div>
            <div class='calculate_box__result--total'>
              <p>--- kCal</p>
            </div>
            <div class='calculate_box__result--form'></div>
          </div>
        </div>
        <div class='bottom_menu_content'>
          <input @click="updateMenus" type="submit" name="commit" value="メニュー更新" class="btn" data-disable-with="メニュー更新">
          <router-link class="btn" to="/menu">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import backGround from '../service/background.service';
import MenuItem from './menu/menu_item.vue'
export default {
  data() {
    return {
      menu: {
        material: "",
        names: [],
        masses: [],
        total_protain: "",
        total_fat: "",
        total_curbohydrate: ""
      },
      updateMenu: false
    };
  },
  components: { MenuItem },
  created() {
    backGround.getEditMenusBoard(this.$route.params['menuId'])
    .then( res => {
      this.menu.material = res.data.material
      res.data.names.forEach( elem => {
        this.menu.names.push(Number(elem))
      })
      res.data.masses.forEach( elem => {
        this.menu.masses.push(Number(elem))
      })
      this.menu.total_protain = res.data.total_protain
      this.menu.total_fat = res.data.total_fat
      this.menu.total_curbohydrate = res.data.total_curbohydrate

      let num = this.menu.names.length

      for(let i = 0; i < num - 1; i++){
        this.appendItem()
      }
    });
  },
  beforeUpdate() {
    let target = document.getElementById('menu_names');
    let num = target.length

    for(let j = 0; j < num; j++){
      let index = this.menu.names[j]
    }
    console.log(target[0])
  },
  methods: {
    updateMenus() {
      axios
      .patch("api/v1/menu/:logId", { menu: this.data })
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
            class: 'nitification__error'
          })
        }      
      })
      .catch( error => { console.log(error) });
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
      let num = document.getElementById('item_form').childElementCount;
      let val = document.getElementsByClassName('mass');
      let foodVal = document.getElementsByClassName('food_index');
      this.menu.masses = [];
      this.menu.names = [];
      
      for(let i = 0; i < num; i++) {
        if (foodVal[i].value == 0) { continue; }
        this.menu.names.push(parseFloat(foodVal[i].value));
        if (val.length != foodVal.length && i == num -1) {
          this.menu.masses.push(parseFloat(val[(i - 1)].value));
        }else{
          this.menu.masses.push(parseFloat(val[i].value));
        }
      }
    },
    result(mass) {
      this.protain.push(parseFloat(mass[0]))
      this.fat.push(parseFloat(mass[1]))
      this.carbo.push(parseFloat(mass[2]))

      this.menu.total_protain = Math.round(this.protain.reduce((num, elem) => num += elem, 0))
      this.menu.total_fat = Math.round(this.fat.reduce((num, elem) => num += elem, 0))
      this.menu.total_carbohydrate = Math.round(this.carbo.reduce((num, elem) => num += elem, 0))
      this.total = Math.round(this.menu.total_protain + this.menu.total_fat + this.menu.total_carbohydrate)
    }
  }
}
</script>
