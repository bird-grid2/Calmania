<template>
  <fieldset>
    <select name="log[menu_numbers][]" id="log_menu_numbers" @change="calculateItem">
      <template v-for="(menu, index) in menus" >
        <option  :value="index" :key="index">{{menu}}</option>
      </template>
    </select>
  </fieldset>  
</template>


<script>
import backGroundService from '../../service/background.service'
export default {
  data(){
    return {
      menus: [],
      total_protain: [],
      total_fat: [],
      total_carbohydrate: []
    }
  },
  mounted() {
    backGroundService.getMenusBoard()
    .then( res => {
      this.menus.push("メニューを選択して下さい");
      res.data.forEach( elem => {
        this.menus.push(elem.material)
        this.total_protain.push(Number(elem.total_protain))
        this.total_fat.push(Number(elem.total_fat))
        this.total_carbohydrate.push(Number(elem.total_carbohydrate))
      });
    })
    .catch( error => { console.log(error) })
  },
  methods: {
    calculateItem(e) {
      let num = e.target.options.selectedIndex - 1

      if (num == -1) {
        this.$emit('delete-event')
      }else{
        this.$emit('calculate-event', [ this.total_protain[num], this.total_fat[num], this.total_carbohydrate[num] ])
      }
    }
  }
}
</script>