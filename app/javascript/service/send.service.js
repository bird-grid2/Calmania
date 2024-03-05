import axios from 'axios'

export class SendService {
  constructor() {
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
  postMenuSearch(input) {
    return this.instance.post('/api/v1/menus/search', { keyword: input });
  }
  postMenuNumber(input) {
    return this.instance.post('/api/v1/logs/menu', { menu_number: input })
  }
  postMenu(input) {
    return this.instance.post('api/v1/menus', { menu: input });
  }
  updateMenu(menuId, input) {
    return this.instance.patch(`api/v1/menus/${menuId}`, { menu: input });
  }
  postLog(input) {
    return this.instance.post('api/v1/logs', { log: input });
  }
  updateLog(logId, input) {
    return this.instance.patch(`api/v1/logs/${logId}`, { log: input });
  }
  postLogSearch(input) {
    return this.instance.post('api/v1/logs/search', { keyword: input });
  }
  postLogdSearch(input) {
    return this.instance.post('api/v1/logs/dsearch', { keyword2: input });
  }
  deleteLog(logId, input) {
    return this.instance.delete(`api/v1/logs/${logId}`, { log: input })
  }
  deleteMenu(menuId, input) {
    return this.instance.delete(`api/v1/menus/${menuId}`, { menu: input })
  }
  updateUser(userId, input) {
    return this.instance.patch(`api/v1/user/${userId}/update`, { user: input })
  }
  signOut(token) {
    return this.instance.delete(`/api/v1/users/sign_out`, { auth_token: token });
  }
}

export default new SendService();