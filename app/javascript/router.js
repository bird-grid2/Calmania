import Vue from "vue";
import Router from "vue-router";
import Index from "./component/index.vue";
import Graph from "./component/graph.vue";
import Management from "./component/management.vue";
import Menu from "./component/menu.vue";
import menuEdit from "./component/menuEdit.vue";
import Log from "./component/log.vue";
import logEdit from "./component/logEdit.vue";
import signIn from "./component/devise/sessions/logIn.vue";
import signUp from "./component/devise/registrations/new.vue";
import userEdit from "./component/devise/registrations/edit.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    { path: "/", name: "index", component: Index }, { path: "/management", name: "managements", component: Management },
    { path: "/menu", name: "menus", component: Menu }, { path: "/menu/:menuId/edit", name: "menuEdit", component: menuEdit },
    { path: "/log", name: "logs", component: Log}, { path: "/log/:logId/edit", name: "logEdit", component: logEdit },
    { path: "/signIn", name: "signIn", component: signIn }, { path: "/signUp", name: "singUp", component: signUp },
    { path: "/user/:userId/edit", name: "userEdit", component: userEdit }, { path: "/graph", name: "graphs", component: Graph }
  ]
});