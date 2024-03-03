<template>
  <fieldset>
    <v-select class="menu_index" id="log_menu_numbers" :options="menus" label="material" v-model="inputMenu" :reduce="menus => menus.id" />
    <p class='select_value' :style="{display: 'none' }">{{ selected }}</p>
  </fieldset>  
</template>

<script>
import { BackgroundService } from '../../../service/background.service'
export default {
  data(){
    return {
      menus: [],
      total_protain: [],
      total_fat: [],
      total_carbohydrate: [],
      selected: 'メニューを選択して下さい'
    }
  },
  created() {
    const instance = new BackgroundService()
    instance.getMenusBoard()
    .then( res => {
      this.menus.push({ id: 0, material: "メニューを選択して下さい" });
      res.data.forEach( elem => {
        this.menus.push({ id: elem.id, material: elem.material })
        this.total_protain.push(Number(elem.total_protain))
        this.total_fat.push(Number(elem.total_fat))
        this.total_carbohydrate.push(Number(elem.total_carbohydrate))
      });
      console.log(this.menus)
    })
    .catch( error => { console.log(error) })
    console.log('select bc')
  },
  methods: {
    calculateItem(args) {
      let num = args - 1

      if (num == -1) {
        this.$emit('delete-event')
      }else{
        this.$emit('calculate-event', [ this.total_protain[num], this.total_fat[num], this.total_carbohydrate[num] ])
      }
    }
  },
  computed: {
    inputMenu: {
      get() {
        return this.selected;
      },
      set(val) {
        console.log(val);
        this.selected = val;
        this.calculateItem(val);
      }
    }
  }
}
</script>