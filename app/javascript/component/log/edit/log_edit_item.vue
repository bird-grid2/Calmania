<template>
  <div class='menu_columns__col'>
    <div class='menu_columns__col__label'>
      <font-awesome-icon :icon="['fas', 'plus-circle']" id='menu-plus' :style="iconStyle" @click="plusItem" />
      <font-awesome-icon :icon="['fas', 'minus-circle']" id='menu-minus' :style="iconStyle" @click="deleteAction" v-if="minus" />
    </div>
    <div class='input_name'>
      <menu-select @delete-event="deleteItem" @calculate-event="calculateEvent($event)" />
    </div>
    <div class='input_name_box' id='box' v-show="caloryShow" >
      <div class="show_protain" >
        <h2>タンパク質 合計</h2>
        <div class="label">
          <h3 name="total_protain">{{ protain }}</h3>
          <p>[kCal]</p>
        </div>
      </div>
      <div class="show_fat">
        <h2>脂質 合計</h2>
        <div class="label">
          <h3 name="total_fat" >{{ fat }}</h3>
          <p>[kCal]</p>
        </div>
      </div>
      <div class="show_carbohydrate">
        <h2>炭水化物 合計</h2>
        <div class="label">
          <h3 name="total_carbohydrate">{{ carbohydrate }}</h3>
          <p>[kCal]</p>
        </div>
      </div>
      <div class="show_cal">
        <h2>総カロリー</h2>
        <div class="label">
          <h3>{{ Math.round( protain + fat + carbohydrate ) }}</h3>
          <p>[kCal]</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import menuSelect from '../menu_select.vue'
import background from '../../../service/background.service'
export default {
  data() {
    return {
      protain: "",
      fat: "",
      carbohydrate: "",
      iconStyle: {
        display: 'block',
        width: '100%',
        color: 'white',
        fontSize: '3.5rem',
        marginBottom: '5%'
      },
      minus: false,
      caloryShow: false,
      menuNumber: ''
    }
  },
  components: { menuSelect },
  created() {
    let mData = 0;
    let self = this;
    console.log(this.menuNumber)
    loadMenu(this.menuNumber);
    console.log('item c');

    async function loadMenu(args){
     mData = await background.getEditMenusBoard(args).catch(err => console.log(err));
     self.protain = mData.data.total_protain;
     self.fat = mData.data.total_fat;
     self.carbohydrate = mData.data.total_carbohydrate;
     self.caloryShow = true;
    }
  },
  methods: {
    plusItem() {
      this.$emit('plus-event');
    },
    deleteAction() {
      this.$emit('reset-event')
      this.$destroy();
      this.$el.parentNode.removeChild(this.$el);
    },
    calculateEvent(calory) {
      this.protain = calory[0]
      this.fat = calory[1]
      this.carbohydrate = calory[2]
      this.caloryShow = true;
      this.$emit('calculate-event', [ calory[0], calory[1], calory[2] ]);
    },
    deleteItem() {
      this.caloryShow = false;
    }
  }
}
</script>