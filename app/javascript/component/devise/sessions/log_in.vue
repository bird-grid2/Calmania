<template>
  <div class='user_wrapper'>
    <header>
      <h2>ログイン画面</h2>
      <img src='/assets/b_ornament_146_0S.png'>
    </header>
    <form @submit.prevent  action="api/v1/users/sign_in" accept-charset="UTF-8" method="post">
      <div class='left_box'>
        <div class='field'>
          <label class="log-in" for="user_nickname_ニックネーム">ニックネーム</label>
          <input autofocus="autofocus" placeholder="ニックネームを入力してください" required="required" type="text" name="user[nickname]" id="user_nickname" v-model="user.nickname">
        </div>
        <div class='field'>
          <label class="log-in" for="user_email_メールアドレス">メールアドレス</label>
          <input placeholder="メールアドレスを入力してください" required="required" type="email" value="" name="user[email]" id="user_email" v-model="user.email">
        </div>
        <div class='field'>
          <label class="log-in" for="user_password_パスワード">パスワード</label>
          <input placeholder="パスワードを入力してください" required="required" type="password" name="user[password]" id="user_password" autocomplete="off" v-model="user.password">
        </div>
      </div>
      <div class='border-line'></div>
      <div class='right_box'>
        <div class='actions'>
          <button id="login" @click="logInUsers">ログイン</button>
        </div>
        <div class='bottom_field'>
          <router-link class="bottom_field_label" :to="{ name: 'signUp' }">ID 新規作成</router-link>
          <button class="bottom_field_label" id="easy_login" @click="easyLogin">かんたんログイン</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      user: {
        nickname: "",
        email: "",
        password: ""
      }
    }
  },
  methods: {
    logInUsers() {
      axios
      .post('/api/v1/users/sign_in', { 
        nickname: this.user.nickname,
        email: this.user.email,
        password: this.user.password 
      })
      .then(res => {
        if(res.data){
          sessionStorage.setItem('user', JSON.stringify(res.data))
        }

        if(res.data != "NG") {
          this.$router.push({ name: "management",
            params: {
              userId: res.data.id
            }
          });
          this.flashMessage.success({
            message: "ログイン完了しました。",
            time: 3000,
            blockClass: "notification__success"
          });
          
        }else{
          this.user.nickname = ''
          this.user.email = ''
          this.user.password = ''
          this.flashMessage.error({
            message: "ログインに失敗しました。",
            time: 3000,
            blockClass: "notification__alert"
          });
        }
      })
      .catch(error => { 
        console.log(error)
      });
    },
    easyLogin() {
      this.user.nickname = 'test-user';
      this.user.email = 'test-user-calmania@gmail.com';
      this.user.password = '65oihue8';
      document.getElementById('login').click();
    }
  }
}
</script>