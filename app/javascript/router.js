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
    { path: "/api/v1/", name: "index", component: Index },
    { path: "/api/v1/sign_in", name: "signIn", component: SignIn }, 
    { path: "/api/v1/sign_up", name: "signUp", component: SignUp },
    { path: "/api/v1/graph", name: "graphs", component: Graph },  
    { path: "/api/v1/log", name: "createLog", component: CreateLog },
    { path: "/api/v1/menus", name: "menus", component: Menu }, 
    { path: "/api/v1/menu", name: "createMenu", component: CreateMenu },
    { path: "/api/v1/menu/:menuId/edit", name: "menuEdit", component: EditMenu }, 
    { path: "/api/v1/users/:userId/edit", name: "editUser", component: EditUser }, 
    { path: "/api/v1/users/:userId/management", name: "management", component: Management },
    { path: "/api/v1/users/:userId/log", name: "logs", component: Log }, 
    { path: "/api/v1/users/:userId/log/:logId/edit", name: "editLog", component: EditLog },
    { path: "*", component: NotFound }
  ]
});

export default router
