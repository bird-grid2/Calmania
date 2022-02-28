import axios from 'axios';
let user = JSON.parse(sessionStorage.getItem('user'));

const instance = axios.create({
  baseURL: process.env.API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
    'Authorization' : "Bearer " + user.auth_token
  },
  responseType: 'json'
})

class  BackgroundSevice {
  getManagementsBoard() {
    return instance.get('/api/v1/managements');
  }
  getLogsBoard() {
    return instance.get('/api/v1/logs');
  }
  getEditLogsBoard(args) {
    return instance.get('api/v1/logs/edit', {params: { logId: args}})
  }
  getMenusBoard() {
    return instance.get('/api/v1/menus');
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