<template>
  <div class='wrapper'>
    <div class='logs_create_wrapper'>
      <form id="logs" action="/logs" accept-charset="UTF-8" method="post">
        <div class='input-form'>
          <div class='upper_content'>
            <div class='input_column'>
              <p>記録日 :</p>
              <input class="input_box" type="date" name="log[date]" id="log_date">
            </div>
            <div class='input_column'>
              <p>体重 [kg] :</p> 
              <input step="0.1" class="input_box" type="number" name="log[weight]" id="log_weight">
            </div>
            <div class='input_column'>
              <p>体脂肪率 [%] :</p> 
              <input step="0.1" class="input_box" type="number" name="log[bfp]" id="log_bfp">
            </div>
          </div>
          <div class='comment_box'>
            <p>コメント :</p> 
            <textarea class="comment" name="log[description]" id="log_description"></textarea>
          </div>
          <div class='menu_columns'>
            <div class='menu_columns__col'>
              <div class='menu_columns__col__label'>
                <i class='fas fa-plus-circle icon' id='menu-plus'></i>
              <div class='input_name'>
                <select name="log[menu_numbers][]" id="log_menu_numbers"></select>
              <div class='input_name_box_0#box'></div>
            </div>
          </div>
        </div>
        <div class='bottom_content'>
          <div class='show_calory'>
            <div class='show_calory--protain'>
              <h2>タンパク質 合計</h2>
              <div class='label'>
                <h3>----</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--fat'>
              <h2>脂質 合計</h2>
              <div class='label'>
                <h3>----</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--carbohydrate'>
              <h2>炭水化物 合計</h2>
              <div class='label'>
                <h3>----</h3>
                <p>[kCal]</p>
              </div>
            </div>
            <div class='show_calory--total'>
              <h2>総カロリー</h2>
              <div class='label'>
                <h3>----</h3>
                <p>[kCal]</p>
              </div>
            </div>
          </div>
          <input type="submit" name="commit" value="ログ作成" class="btn" data-disable-with="ログ作成">
          <router-link class="btn" to="/logs">キャンセル</router-link>
        </div>
      </form>
    </div>
  </div>
</template>