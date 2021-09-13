<template>
  <fieldset>
    <v-select class="food_index" id="menu_names" :options="foods" label="food" v-model="selected" :reduce="foods => foods.id"  @input="enableMass($event)" />
    <p class='select_value' :style="{display: 'none' }">{{ selected }}</p>
  </fieldset>  
</template>


<script>
import backGroundService from '../../service/background.service'
export default {
  data(){
    return {
      selected: '選択して下さい',
      foods: []
    }
  },
  created() {
    backGroundService.getFoodsBoard()
    .then( res => {
      this.foods.push({ id: 0, food: "選択して下さい" });
      res.data.forEach( elem => {
        this.foods.push({ id: elem.id, food: elem.element })
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
