<template>
  <div class='input_form__column'>
    <div class='input_form__column__label'>
      <font-awesome-icon :icon="['fas', 'plus-circle']" class='icon' id='menu-plus' :style="iconStyle" @click="plusMenu" />
      <font-awesome-icon :icon="['fas', 'minus-circle']" class="icon" id="menu-minus" :style="iconStyle" @click="deleteAction" v-if="displayMenu" />
    </div>
    <div class='input_form__column__input_name' id='name'>
      <food @enable-mass="turnMass" ref="food" />
      <div class="label" v-if="displayMass">
        <p>重量 [g] :</p>
        <input class="mass" id="menu_masses" type="number" name="menu[masses][]" v-model="inputMass">
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
import backGround from '../../../service/background.service'
import Food from '../food.vue'
export default {
  data () {
    return {
      protain: 0.00,
      fat: 0.00,
      carbohydrate: 0.00,
      mass: '',
      foodNumber: '',
      protainRate: '',
      fatRate: '',
      carboHydrateRate: '',
      displayMass: false,
      displayCalory: false,
      displayMenu: false,
      updateMenu: false,
      iconStyle: {
        display: 'block',
        width: '100%',
        color: '$maincolor',
        fontSize: '3.5rem',
        marginBottom: '5%'
      }
    }
  },
  components: { Food },
  mounted() {
    this.protainRate = backGround.getEditFoodsBoard(this.foodNumber).protainData
    this.fatRate = backGround.getEditFoodsBoard(this.foodNumber).fatData
    this.carboHydrateRate = backGround.getEditFoodsBoard(this.foodNumber).carboData
    console.log(this.protainRate)
  },
  methods: {
    turnMass() {
      this.displayMass = true;
    },
    turnCalory() {
      this.displayCalory = true;
    },
    appendMasses() {
      this.$emit('reset-event')
    },
    plusMenu() {
      this.$emit('plus-event')
    },
    deleteAction() {
      this.$emit('reset-event')
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
    },
    calculateCal() {
      let index = this.$refs.food.selected - 1
      this.protain = Math.round(this.protainRate[index] * this.mass * 4) / 10
      this.fat = Math.round(this.fatRate[index] * this.mass * 9) / 10 
      this.carbohydrate = Math.round(this.carboHydrateRate[index] * this.mass * 4) / 10
      return this.$emit('calculate-event')
    }
  },
  computed: {
    totalCal: function() {
      let target = Math.round((this.protain + this.fat + this.carbohydrate) * 10) / 10;
      return target;
    },
    inputMass: {
      get() {
        return this.mass;
      },
      set(value) {
        this.mass = value;
      }
    }
  },
  watch: {
    mass: function() {
      this.turnCalory();
      
      this.appendMasses();
    }
  }
}
</script>
