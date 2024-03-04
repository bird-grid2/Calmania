import axios from 'axios';

export class BackgroundService {
  constructor(){
    let target = 0;

    if (JSON.parse(sessionStorage.getItem('user'))) {
      target = axios.create({
        baseURL: process.env.API_BASE_URL,
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': "Bearer " + JSON.parse(sessionStorage.getItem('user')).user.token
        },
        responseType: 'json'
      });
    } else {
      target = axios.create({
        baseURL: process.env.API_BASE_URL,
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': "Bearer "
        },
        responseType: 'json'
      });
    }

    this.instance = target;
  }
  getUsersBoard(args) {
    return this.instance.get('api/v1/user/load_data', {params: { token: args.data }});
  }
  getManagementsBoard(args) {
    return this.instance.get('/api/v1/managements');
  }
  getLogsBoard() {
    return this.instance.get('/api/v1/logs');
  }
  getEditLogsBoard(args) {
    return this.instance.get('api/v1/logs/edit', {params: { id: args}})
  }
  getMenusBoard() {
    return this.instance.get('/api/v1/logs/menu_data');
  }
  getEditMenusBoard(args) {
    return this.instance.get('api/v1/menus/edit', { params: { id: args }})
  }
  getFoodsBoard() {
    return this.instance.get('/api/v1/menus');
  }
  getEditFoodsBoard(args) {
    return this.instance.get('/api/v1/menus/food_data', { params: { id: args } })
  }
}

export default new BackgroundService();