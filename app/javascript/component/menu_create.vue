<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form @submit.prevent action='/api/v1/menus' id="menu" accept-charset="UTF-8" method='post'>
        <div class='upper_menu_content'>
          <p>{{ masses }}</p>
          <p>MenuName :</p> 
          <input class="menu_name" type="text" name="menu[material]" id="menu_material">
        </div>
        <div class='input_form' id="item_form">
          <menu-item @plus-event="appendItem" @append-mass="massList($event)" />
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
          <input @click="createMenus" type="submit" name="commit" value="メニュー作成" class="btn" data-disable-with="メニュー作成">
          <router-link class="btn" to="/menus">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import axios from 'axios';
import MenuItem from './menu/menu_item.vue'
export default {
  data() {
    return {
      material: "",
      names: [],
      masses: [],
      total_protain: "",
      total_fat: "",
      total_curbohydrate: ""
    }
  },
  components: { MenuItem },
  methods: {
    createMenus() {
      axios
      .post("api/v1/menus", { menu: this.data })
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
      instance.$on('append-mass', this.massList)
      instance.displayMenu = true
      instance.$mount();
      target.append(instance.$el)
    },
    elementCount() {
      let target = document.getElementById('item_form');
      let res = target.childElementCount;
      return res
    },
    massList() {
      let num = this.elementCount();
      let val = document.getElementsByClassName('mass');
      this.masses = [];
      
      for(let i = 0; i < num; i++) {
        if (val[i] === undefined) { continue; }
        this.masses.push(parseFloat(val[i].value));
      }
    }
  }
}
</script>
