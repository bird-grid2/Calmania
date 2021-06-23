<template>
  <div class='user_wrapper sp'>
    <header>
      <h2>ユーザー情報編集</h2>
      <img src='/assets/b_ornament_146_0S.png'>
    </header>
    <form class="edit_user" id="edit_user" action="/users" accept-charset="UTF-8" method="post">
      <div class='left_box'>
        <div class='field'>
          <label class="edit" for="user_nickname_ニックネーム">ニックネーム</label>
          <input autofocus="autofocus" autocomplete="name" required="required" type="text" name="user[nickname]" id="user_nickname">
        </div>
        <div class='field'>
          <label class="edit" for="user_email_メールアドレス">メールアドレス</label>
          <input autofocus="autofocus" autocomplete="email" required="required" type="email" name="user[email]" id="user_email">
        </div>
        - if devise_mapping.confirmable? && resource.pending_reconfirmation?
          <div>Currently waiting confirmation for: #{resource.unconfirmed_email}</div>
        <div class='field'>
          <label class="edit" for="user_height_身長_cm">身長 [cm]</label>
          <input autocomplete="height" placeholder="身長を入力(任意)" type="number" name="user[height]" id="user_height">
        </div>
        <!-- <div class='field'>
          = f.label :target_cal, value: '目標摂取カロリー' , class:'edit'
          = f.number_field :target_cal, autocomplete: "target_cal", placeholder: '目標摂取カロリー(任意)'
        </div>
        <div class='field'>
          = f.label :ideal_PFC_rate, value: 'ＰＦＣバランス' , class:'edit'
          = f.number_field :ideal_protain_rate, autocomplete: "ideal_protain_rate", placeholder: 'たんぱく質の摂取割合(任意)'
          = f.number_field :ideal_fat_rate, autocomplete: "ideal_fat_rate", placeholder: '脂質の摂取割合(任意)'
          = f.number_field :ideal_carbohydrate_rate, autocomplete: "ideal_carbohydrate_rate", placeholder: '炭水化物の摂取割合(任意)'
        </div> -->
        = f.fields_for :clock_work_event, resource.clock_work_event ? resource.clock_work_event : resource.build_clock_work_event do |form|
          <div class='field'>
            <label class="edit" for="user_clock_work_event_attributes_Remainder機能 (LINE 公式アカウント: @681lurjb)">Remainder機能 (line 公式アカウント: @681lurjb)</label>
            <p>privateなアカウントには登録しないでください</p>
            <select name="user[clock_work_event_attributes][period_id]" id="user_clock_work_event_attributes_period_id">
              <option value="0">OFF(任意)</option>
              <option value="1">毎日</option>
              <option value="2">1日毎</option>
              <option value="3">2日毎</option>
              <option value="4">3日毎</option>
              <option value="5">1週間毎</option>
            </select>
          </div>
          <div class='field'>
            <label class="edit" for="user_clock_work_event_attributes_送信時間">送信時間</label>
            <input type="time" name="user[clock_work_event_attributes][send_time]" id="user_clock_work_event_attributes_send_time">
          </div>
        </div>
      <div class='border-line'></div>
      <div class='right_box'>
      <div class='field'>
        <div class='edit_label'>
          <label for="user_password_変更パスワード">変更パスワード</label>
          <i>(変更しない場合、空白)</i>
        </div>
        <em>{{ passwordCount }}</em>
        <input autocomplete="new-password" placeholder="変更パスワード入力" type="password" name="user[password]" id="user_password">
      </div>
      <div class='field'>
        <label class="label" for="user_password_confirmation_変更パスワード確認">変更パスワード確認</label>
        <input autocomplete="new-password" placeholder="変更パスワード確認" type="password" name="user[password_confirmation]" id="user_password_confirmation">
      </div>
      <div class='field'>
        <div class='edit_label'>
          <label class="label" for="user_current_password_現行パスワード">現行パスワード</label>
          <i>(情報更新時に入力)</i>
        </div>
        <input autocomplete="current-password" placeholder="現行パスワード入力" required="required" type="password" name="user[current_password]" id="user_current_password">
      </div>
      <div class='actions'>
        <input type="submit" name="commit" value="ユーザー情報更新" id="edit_submit" data-disable-with="ユーザー情報更新" @click=updateUsers>
      </div>
      <div class='footer'>
        <router-link data-confirm="本当に削除しますか?" class="red-btn" rel="nofollow" data-method="delete" to="/users">ユーザー情報削除</router-link>
        <router-link class="btn" to="/managements">戻る</router-link>
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
        password_confirmation: "",
        current_password: "",
        target_cal: "",
        ideal_protain_rate: "",
        ideal_fat_rate: "",
        ideal_carbohydrate_rate: "",
        clock_work_event_attributes: { preriod_id: "", send_time: "" }
      }
    }
  },
  methods: {
    updateUsers() {
      axios
      .post("api/v1/users/registrations/update", { user: this.user })
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