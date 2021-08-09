import axios from 'axios';
import authHeader from './authHeader';

const instance = axios.create({
  baseURL: process.env.API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  },
  responseType: 'json'
})

class  BackgroundSevice {
  getManagementsBoard() {
    return instance.get('/api/v1/managements', { headers: authHeader() });
  }
  getLogsBoard() {
    return instance.get('/api/v1/logs', { headers: authHeader() });
  }
  getMenusBoard() {
    return instance.get('/api/v1/menus', { headers: authHeader() });
  }
}

export default new BackgroundSevice();
