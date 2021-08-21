import axios from 'axios'
let user = JSON.parse(sessionStorage.getItem('user'));

const instance = axios.create({
  baseURL: process.env.API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
    'Authorization': "Bearer " + user.auth_token, 
  },
  responseType: 'json'
})

class  SendSevice {
  postMenuSearch(input) {
    return instance.post('/api/v1/menus/search', { keyword: input });
  }
  postMenu(input) {
    return instance.post('api/v1/menus', { menu: input })
  }
}

export default new SendSevice();