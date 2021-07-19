<template>
  <div class='user_wrapper'>
    <header>
      <h2>ログイン画面</h2>
      <img src='/assets/b_ornament_146_0S.png'>
    </header>
    <form class="new_user" id="new_user" action="users/sessions" accept-charset="UTF-8">
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
          <input placeholder="パスワードを入力してください" required="required" type="password" name="user[password]" id="user_password" v-model="user.password">
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
      user: {
        nickname: "",
        email: "",
        password: "",
        jti: "",
        height: "",
      }
    }
  },
  methods: {
    logInUsers() {
      axios
      .post("/users/sign_in", this.user )
      .then( res => { this.$router.push({ path: "/management" })})
      .catch( error => { this.$router.push({ path: "/signIn" })});
    },
    easyLogin() {
      document.getElementById('user_nickname').value = 'test-user';
      document.getElementById('user_email').value = 'test-user-calmania@gmail.com';
      document.getElementById('user_password').value = '65oihue8';
      document.getElementById('login').click();
    }
  }
}
</script>