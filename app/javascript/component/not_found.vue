<template>
  <div class="main">
    <div class="card">
      <div class="header">
        <h1><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">ページが見つかりません</font></font></h1>
      </div>
      <div class="body">
        <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">壊れたリンクをたどったか、このサイトに存在しないURLを入力したようです。</font></font></p>
        <p>
          <router-link id="back-link" to="/">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
              <path fill="#007067" d="M11.9998836,4.09370803 L8.55809517,7.43294953 C8.23531459,7.74611298 8.23531459,8.25388736 8.55809517,8.56693769 L12,11.9062921 L9.84187871,14 L4.24208544,8.56693751 C3.91930485,8.25388719 3.91930485,7.74611281 4.24208544,7.43294936 L9.84199531,2 L11.9998836,4.09370803 Z"></path>
            </svg>
            <font style="vertical-align: inherit;">
              <font style="vertical-align: inherit;">当サイトに戻る</font>
            </font>
          </router-link>
        </p>
        <hr>
      </div>
    </div>
  </div>
</template>

<script>
  (function() {
    if (document.referrer && document.location.host && document.referrer.match(new RegExp("^https?://" + document.location.host))) {
      document.getElementById("back-link").setAttribute("href", document.referrer);
    }
  })();
</script>