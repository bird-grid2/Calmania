import axios from 'axios'
let target = 0;

if(JSON.parse(sessionStorage.getItem('user')).user.token){
  target = axios.create({
    baseURL: process.env.API_BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization' : "Bearer " + JSON.parse(sessionStorage.getItem('user')).user.token
    },
    responseType: 'json'
  });
} else {
  target = axios.create({
    baseURL: process.env.API_BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization' : "Bearer "
    },
    responseType: 'json'
  });
}

const instance = target;

class  SendSevice {
  postMenuSearch(input) {
    return instance.post('/api/v1/menus/search', { keyword: input });
  }
  postMenuNumber(input) {
    return instance.post('/api/v1/logs/menu', { menu_number : input })
  }
  postMenu(input) {
    return instance.post('api/v1/menus', { menu: input });
  }
  updateMenu(menuId, input){
    return instance.patch(`api/v1/menus/${ menuId }`, { menu: input});
  }
  postLog(input) {
    return instance.post('api/v1/logs', { log: input });
  }
  updateLog(logId, input) {
    return instance.patch(`api/v1/logs/${logId}`, { log: input });
  }
  postLogSearch(input) {
    return instance.post('api/v1/logs/search', { keyword: input });
  }
  postLogdSearch(input) {
    return instance.post('api/v1/logs/dsearch', { keyword2: input });
  }
  deleteLog(logId, input) {
    return instance.delete(`api/v1/logs/${logId}`, { log: input })
  }
  deleteMenu(menuId, input) {
    return instance.delete(`api/v1/menus/${menuId}`, { menu: input })
  }
  updateUser(userId, input){
    console.log(input)
    return instance.patch(`/api/v1/user/${userId}/update`, { user: input })
  }
  signOut(token){
    return instance.delete(`/api/v1/users/sign_out`, { data: token });
  }
}

export default new SendSevice();