<template>
  <div class='user_wrapper'>
    <header>
      <h2>ログイン画面</h2>
      <img src='/assets/b_ornament_146_0S.png'>
    </header>
    <form @submit.prevent class="new_user" id="new_user" action="api/v1/users/sign_in" accept-charset="UTF-8" method="post">
      <div class='left_box'>
        <div class='field'>
          <label class="log-in" for="user_nickname_ニックネーム">ニックネーム</label>
          <input autofocus="autofocus" placeholder="ニックネームを入力してください" required="required" type="text" name="user[nickname]" id="user_nickname" v-model="nickname">
        </div>
        <div class='field'>
          <label class="log-in" for="user_email_メールアドレス">メールアドレス</label>
          <input placeholder="メールアドレスを入力してください" required="required" type="email" value="" name="user[email]" id="user_email" v-model="email">
        </div>
        <div class='field'>
          <label class="log-in" for="user_password_パスワード">パスワード</label>
          <input placeholder="パスワードを入力してください" required="required" type="password" name="user[password]" id="user_password" v-model="password">
        </div>
      </div>
      <div class='border-line'></div>
      <div class='right_box'>
        <div class='check_field'>
          <input name="user[remember_me]" type="hidden" value="0">
          <input type="checkbox" value="1" name="user[remember_me]" id="user_remember_me">
          <label for="user_remember_me_ログイン情報を記憶する">ログイン情報を記憶する</label>
        </div>
        <div class='actions'>
          <button id="login" @click="logInUsers">ログイン</button>
        </div>
        <div class='bottom_field'>
          <router-link class="bottom_field_label" to="/users/sign_up">ID 新規作成</router-link>
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
      nickname: "",
      email: "",
      password: ""
    }
  },
  methods: {
    logInUsers() {
      axios
      .post('/api/v1/users/sign_in', { 
        nickname: this.nickname,
        email: this.email,
        password: this.password 
      })
      .then(res => {
        console.log(res)
        this.$router.push({ name: "management", params: { managementId: res.data.id}})
      })
      .catch(error => { 
        this.$router.push({ name: "signIn" })
        console.log(error)
      });
    },
    easyLogin() {
      this.nickname = 'test-user';
      this.email = 'test-user-calmania@gmail.com';
      this.password = '65oihue8';
      document.getElementById('login').click();
    }
  }
}
</script>