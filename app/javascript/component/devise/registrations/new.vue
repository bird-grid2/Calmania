<template>
  <div class='user_wrapper'>
    <header>
      <h2>新規作成</h2>
      <img src='/assets/b_ornament_146_0S.png'>
    </header>
    <form class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post">
      <div class="left_box">
        <div class="field">
          <label class="new" for="user_nickname_ニックネーム_必須">ニックネーム (必須)</label>
          <input autofocus="autofocus" placeholder="ニックネームを入力してください" required="required" type="text" name="user[nickname]" id="user_nickname" v-model="nickname">
        </div>
        <div class="field">
          <label class="new" for="user_email_メールアドレス_必須">メールアドレス (必須)</label>
          <input placeholder="メールアドレスを入力してください" required="required" type="email" value="" name="user[email]" id="user_email" v-model="email">
        </div>
        <div class="field">
          <label class="new" for="user_height_身長cm_任意">身長[cm] (任意)</label>
          <input placeholder="身長を入力してください" step="0.1" type="number" name="user[height]" id="user_height" v-model="height">
        </div>
      </div>
      <div class='border-line'></div>
      <div class='right_box'>
        <div class='field'>
          <div class='field-box'>
            <label class="password" required="required" for="user_password_パスワード">パスワード</label>
            <em>{{ passwordCount }}</em>
          </div>
          <input placeholder="パスワード入力" type="password" name="user[password]" id="user_password" v-model="password">
        </div>
        <div class='field'>
          <label class="label" for="user_password_confirmation_確認入力">確認入力</label>
          <input placeholder="パスワード入力(確認)" required="required" type="password" name="user[password_confirmation]" id="user_password_confirmation">
        </div>
        <div class='actions'>
          <input type="submit" name="commit" value="新規作成" data-disable-with="新規作成" @click="createUser">
          <router-link class="new_btn" to="/">戻る</router-link>
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
        height: "",
        password: "",
        password_confirmation: ""
      }
    }
  },
  methods: {
    createUsers() {
      axios
      .post("api/v1/users/registrations/create", { user: this.user })
      .then( (response)=> { this.$router.push({ path: "/management" }); }, (error)=> { console.log(error); });
    }
  },
  computed: {
    passwordCount() {
      count = this.password.length
      return this.password.length <= 6 ? (6 - count) + "文字以上入力" : "文字数OK" 
    }
  }
}
</script>
