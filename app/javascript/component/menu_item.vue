<template>
  <div class='input_form__column'>
    <div class='input_form__column__label'>
      <font-awesome-icon :icon="['fas', 'plus-circle']" class='icon' id='menu-plus' :style="iconStyle" />
    </div>
    <div class='input_form__column__input_name' id='name'>
      <select name="menu[names][]" id="menu_names" @change="turnMass">
        <option v-for="(food, index) in foods" :value="index">{{food}}</option>
      </select>
      <div class="label" v-if="displayMass">
        <p>重量 [g] :</p>
        <input class="mass" id="menu_masses" type="number" name="menu[masses][]" @change="turnCalory(); calculateCal" v-model="mass">
      </div>
    </div>
    <div class='input_form__column__box' id='fbox' v-if="displayCalory">
      <div class='input_form__column__box__protain'> 
        <h2>タンパク質</h2>
        <div class='input_form_warpper'>
          <h3>{{ this.protain == 0.00 ? 0.00 : this.protain }}</h3><p> [kCal]</p>
        </div>
      </div>
      <div class='input_form__column__box__fat'>
        <h2>脂質</h2>
        <div class='input_form_warpper'>
          <h3>{{ this.fat == 0.00 ? 0.00 : this.fat }}</h3><p> [kCal]</p>
        </div>
      </div>
      <div class='input_form__column__box__carbohydrate'>
        <h2>炭水化物</h2>
        <div class='input_form_warpper'>
          <h3>{{ this.carbohydrate == 0.00 ? 0.00 : this.carbohydrate }}</h3><p> [kCal]</p>
        </div>
      </div>
      <div class='input_form__column__box__total_mass'>
        <h2>総カロリー</h2>
        <div class='input_form_warpper'>
          <h3>{{ totalCal }}</h3><p> [kCal]</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import backGroundService from '../service/background.service'
export default {
  data() {
    return {
      foods: [],
      protain: 0.00,
      fat: 0.00,
      carbohydrate: 0.00,
      mass: '',
      protainRate: [],
      fatRate: [],
      carboHydrateRate: [],
      index: '',
      displayMass: false,
      displayCalory: false,
      iconStyle: {
        display: 'block',
        width: '100%',
        color: '$maincolor',
        fontSize: '3.5rem',
        marginBottom: '5%'
      }
    }
  },
  mounted() {
    backGroundService.getFoodsBoard()
    .then( res => {
      this.foods.push("選択して下さい");
      res.data.forEach( elem => {
        this.foods.push(elem.element) 
        this.protainRate.push(elem.protain_rate)
        this.fatRate.push(elem.fat_rate)
        this.carboHydrateRate.push(elem.carbohydrate_rate)   
      });
    })
    .catch( error => { console.log(error) })
  },
  methods: {
    turnMass() {
      this.displayMass = true;
    },
    turnCalory() {
      this.displayCalory = true;
    }
  },
  computed: {
    calculateCal: function(){
      let index = document.getElementById('menu_names').value - 1

      this.protain = Math.ceil(this.protainRate[index] * this.mass * 4) / 10
      this.fat = Math.ceil(this.fatRate[index] * this.mass * 9) / 10 
      this.carbohydrate = Math.ceil(this.carboHydrateRate[index] * this.mass * 4) / 10
    },
    totalCal: function(){
      let target = Math.ceil((this.protain + this.fat + this.carbohydrate) * 10) / 10;
      return target;
    }
  }
}
</script>