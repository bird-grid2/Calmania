export default function authHeader() {
  let user = JSON.parse(sessionStorage.getItem('user'));
  
  if (user && user.auth_token) {
    return { Authorization: 'Bearer ' + user.auth_token };
  } else {
    return {};
  }
}