<template>
  <fieldset>
    <select class="food_index" name="menu[names][]" id="menu_names" @change="enableMass">
      <template v-for="(food, index) in foods" >
        <option  :value="index" :key="index">{{food}}</option>
      </template>
    </select>
  </fieldset>  
</template>


<script>
import backGroundService from '../../service/background.service'
export default {
  data(){
    return {
      foods: []
    }
  },
  mounted() {
    backGroundService.getFoodsBoard()
    .then( res => {
      this.foods.push("選択して下さい");
      res.data.forEach( elem => {
        this.foods.push(elem.element)
      });
    })
    .catch( error => { console.log(error) })
  },
  methods: {
    enableMass() {
      this.$emit('enable-mass', true);
    }
  }
}
</script>
