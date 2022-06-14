import axios from 'axios';
let user = JSON.parse(sessionStorage.getItem('user'));
let target = 0;

if(user == null){
  target = axios.create({
    baseURL: process.env.API_BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization' : "Bearer "
    },
    responseType: 'json'
  })
} else {
  target = axios.create({
    baseURL: process.env.API_BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization' : "Bearer " + user.auth_token
    },
    responseType: 'json'
  })
}

const instance = target;

class  BackgroundSevice {
  getUsersBoard(args) {
    return instance.get('api/v1/user/load_data', {params: { token: args}});
  }
  getManagementsBoard() {
    return instance.get('/api/v1/managements');
  }
  getLogsBoard() {
    return instance.get('/api/v1/logs');
  }
  getEditLogsBoard(args) {
    return instance.get('api/v1/logs/edit', {params: { id: args}})
  }
  getMenusBoard() {
    return instance.get('/api/v1/logs/menu_data');
  }
  getEditMenusBoard(args) {
    return instance.get('api/v1/menus/edit', { params: { id: args }})
  }
  getFoodsBoard() {
    return instance.get('/api/v1/menus/new');
  }
  getEditFoodsBoard(args) {
    return instance.get('/api/v1/menus/food_data', { params: { id: args } })
  }
}

export default new BackgroundSevice();