import { createRouter, createWebHistory } from "vue-router";
import Index from "./component/index.vue";
import Graph from "./component/graph.vue";
import Management from "./component/management.vue";
import Menu from "./component/menu.vue";
import EditMenu from "./component/menu/edit/menu_edit.vue";
import CreateMenu from "./component/menu/create/menu_create.vue"
import Log from "./component/log.vue";
import EditLog from "./component/log/edit/log_edit.vue";
import CreateLog from "./component/log/create/log_create.vue";
import SignIn from "./component/devise/sessions/log_in.vue";
import SignUp from "./component/devise/registrations/new.vue";
import EditUser from "./component/devise/registrations/edit.vue";
import NotFound from "./component/not_found.vue"

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", name: "index", component: Index },
    { path: "/sign_in", name: "signIn", component: SignIn }, 
    { path: "/sign_up", name: "signUp", component: SignUp },
    { path: "/graph", name: "graphs", component: Graph },  
    { path: "/log", name: "createLog", component: CreateLog },
    { path: "/menus", name: "menus", component: Menu }, 
    { path: "/menu", name: "createMenu", component: CreateMenu },
    { path: "/menu/:menuId/edit", name: "menuEdit", component: EditMenu }, 
    { path: "/users/:userId/edit", name: "editUser", component: EditUser }, 
    { path: "/users/:userId/management", name: "management", component: Management },
    { path: "/users/:userId/log", name: "logs", component: Log }, 
    { path: "/users/:userId/log/:logId/edit", name: "editLog", component: EditLog },
    { path: "/:pathMatch(.*)*", component: NotFound }
  ]
});

export default router
