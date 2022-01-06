require("@rails/activestorage").start();
import Vue from 'vue';
import App from '../app.vue';
import router from '../router';
import FlashMessage from '@smartweb/vue-flash-message';
import './application.scss';
import { library } from '@fortawesome/fontawesome-svg-core'
import { faFileAlt, faEdit, faSignOutAlt, faHome, faThList, faPlusCircle, faTrashAlt, faMinusCircle } from '@fortawesome/free-solid-svg-icons'
import { faChartBar } from '@fortawesome/free-regular-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';
import backGround from '../service/background.service'
import send from '../service/send.service'

library.add(faFileAlt, faEdit, faSignOutAlt, faHome, faThList, faPlusCircle, faTrashAlt, faMinusCircle, faChartBar)

Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.component('vSelect', vSelect)
Vue.use(FlashMessage);

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById("app");
  const app = new Vue({
    el: el,
    router: router,
    backGround: backGround,
    send: send,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})

/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.
// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
