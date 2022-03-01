import Vue from "vue";
import Router from "vue-router";
import Index from "./component/index.vue";
import Graph from "./component/graph.vue";
import Management from "./component/management.vue";
import Menu from "./component/menu.vue";
import editMenu from "./component/menu/edit/menu_edit.vue";
import createMenu from "./component/menu/create/menu_create.vue"
import Log from "./component/log.vue";
import editLog from "./component/log/edit/log_edit.vue";
import createLog from "./component/log/create/log_create.vue";
import signIn from "./component/devise/sessions/log_in.vue";
import signUp from "./component/devise/registrations/new.vue";
import editUser from "./component/devise/registrations/edit.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    { path: "/", name: "index", component: Index }, { path: "/:userId/management", name: "management", component: Management },
    { path: "/menus", name: "menus", component: Menu }, { path: "/menu/:menuId/edit", name: "menuEdit", component: editMenu },
    { path: "/menu", name: "createMenu", component: createMenu }, { path: "/:userId/log", name: "logs", component: Log },
    { path: "/log/:userId/edit/:logId", name: "editLog", component: editLog }, { path: "/log", name: "createLog", component: createLog },
    { path: "/signIn", name: "signIn", component: signIn }, { path: "/signUp", name: "singUp", component: signUp },
    { path: "/user/:userId/edit", name: "editUser", component: editUser }, { path: "/graph", name: "graphs", component: Graph }, { path: "*", redirect: "/" }
  ]
});