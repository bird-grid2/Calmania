<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form action='/menus' accept-charset="UTF-8" method='post'>
        <div class='upper_menu_content'>
          <p>MenuName :</p> 
          <input class="menu_name" type="text" name="menu[material]" id="menu_material">
        </div>
        <div class='input_form'>
          <div class='input_form__column'>
            <div class='input_form__column__label'>
              <i class='fas fa-plus-circle icon' id='menu-plus'></i>
            </div>
            <div class='input_form__column__input_name_0#name'>
              <select name="menu[names][]" id="menu_names"></select>
            </div>
          </div>
          <div class='input_form__column__box_0#fbox'></div>
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
          <input @click="createLogs" type="submit" name="commit" value="メニュー作成" class="btn" data-disable-with="メニュー作成">
          <router-link class="btn" to="/menu">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      menus: {
        material: "",
        names: [],
        masses: [],
        total_protain: "",
        total_fat: "",
        total_curbohydrate: ""
      }
    };
  },
  methods: {
    createLogs() {
      axios
      .post("api/v1/logs/create", { menu: menus });
    };
  }
}
</script>

