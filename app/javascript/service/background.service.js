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
  getEditLogsBoard() {
    return instance.get('api/v1/logs/edit')
  }
  getMenusBoard() {
    return instance.get('/api/v1/menus');
  }
  getEditMenusBoard() {
    return instance.get('api/v1/menus/edit', params: { id: menuId })
  }
  getFoodsBoard() {
    return instance.get('/api/v1/menus/new');
  }
}

export default new BackgroundSevice();