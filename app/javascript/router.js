import Vue from "vue";
import Router from "vue-router";
import Index from "./component/index.vue";
import Management from "./component/management.vue";
import Menu from "./component/menu.vue";
import menuEdit from "./component/menuEdit.vue"

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [{ path: "/", component: Index, name: "index"}, { path: "/management", component: Management, name: "managements"},
  { path: "/menu", component: Menu, name: "menus"}, { path: "/menu/:menuId/edit", component: menuEdit, name: "menuEdit"}]
});