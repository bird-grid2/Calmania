<template>
  <div class='wrapper'>
    <div class='food_wrapper'>
      <form @submit.prevent action='/api/v1/menu' accept-charset="UTF-8" method='patch'>
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
          <input @click="updateMenus" type="submit" name="commit" value="メニュー更新" class="btn" data-disable-with="メニュー更新">
          <router-link class="btn" to="/menu">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import backGround from '../service/background.service';
export default {
  data() {
    return {
      material: "",
      names: [],
      masses: [],
      total_protain: "",
      total_fat: "",
      total_curbohydrate: ""
    };
  },
  mounted() {
    backGround.getEditMenusBoard()
    .then( res => {
      console.log(res)
    });
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
    }
    
  }
}
</script>
