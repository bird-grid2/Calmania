<template>
  <fieldset>
    <v-select class="food_index" id="menu_names" :options="foods" label="food" v-model="inputfood" :reduce="foods => foods.id" />
    <p class='select_value' :style="{display: 'none' }">{{ selected }}</p>
  </fieldset>  
</template>


<script>
import backGroundService from '../../service/background.service'
export default {
  props: ['number'],
  data(){
    return {
      selected: '選択して下さい',
      foods: [],
      update: false
    }
  },
  beforeCreate() {
    let self = this
    async function foodData(){
      let fData = await backGroundService.getFoodsBoard().catch( error => { console.log(error) });
      self.foods.push({ id: 0, food: "選択して下さい" }); 
      await fData.data.forEach( elem => { self.foods.push({ id: elem.id, food: elem.element }) })
    }
    foodData();
  },
  beforeUpdate() {
    if(this.update == false){
      this.selected = this.number;

      if(this.selected == ''){ this.selected = '選択して下さい' }

      if(this.selected == '選択して下さい'){
        this.update = true;
      } else {
        this.update = true;
        this.$emit('load-food');
      }
    }
  },
  methods: {
    enableMass() {
      this.$emit('enable-mass', true);
    }
  },
  computed: {
    inputfood : {
      get() {
        return this.selected;
      },
      set(value) {
        this.selected = value;
        this.enableMass();
      }
    }
  }
}
</script>
