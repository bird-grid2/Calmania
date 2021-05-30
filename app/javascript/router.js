import Vue from 'vue';
import Router from 'vue-router';
import Index from './component/index.vue';
import Management from './component/management.vue';

Vue.use(Router);

export default new Router ({
  routes: [{ path: '/', component: Index}, { path: '/management', component: Management}]
});