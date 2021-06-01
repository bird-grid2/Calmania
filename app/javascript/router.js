import Vue from "vue";
import Router from "vue-router";
import Index from "./component/index.vue";
import Management from "./component/management.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [{ path: "/", component: Index, name: 'root_path'}, { path: "/management", component: Management, name: 'managements_path'}]
});