$(document).on('turbolinks:load', function(){
  $('body').on('change', '#log_menus', function(){
    
    var id = $(this).val();

    var target = gon.menu[ id - 1 ]
    
    function appendHTML(log){
      var html = `<div class="show_cal">
                    <h2>タンパク質 合計</h2>
                    <div class="label">
                      <h3>${log.total_protain}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class="show_cal">
                    <h2>脂質 合計</h2>
                    <div class="label">
                      <h3>${log.total_fat}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class="show_cal">
                    <h2>炭水化物 合計</h2>
                    <div class="label">
                      <h3>${log.total_carbohydrate}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class="show_cal">
                    <h2>総カロリー</h2>
                    <div class="label">
                      <h3>${Math.ceil(Number(log.total_protain) + Number(log.total_fat) + Number(log.total_carbohydrate))}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>`
      return html;
    };
    $(this).parent().next().empty();
    $(this).parent().next().append(appendHTML(target));
  });

  //＋ボタン
  $('body').on('click', '#menu-plus', function(){

    var sum  =(arr)=>{
      var sum = 0;
      arr.forEach((elm)=>{
          sum += elm;
      });
      return sum;
    };

    option = []
    
    //menuデータの取得
    gon.menu.forEach((menu)=>{
      var html = `<option value="${menu.id}">${menu.menu}</option>`
      option.push(html);
    });

    //挿入するHTMLの定義
    function addHTML(){

      var html = `<div class="menu_columns__col">
                    <div class="menu_columns__col__label">
                      <i class="fas fa-plus-circle icon" id="menu-plus"></i>
                      <i class="fas fa-minus-circle icon" id="menu-minus"></i>
                    </div>
                    <div class="input_name">
                      <select name="log[menus][]" id="log_menus"><option value="">メニューを選択して下さい</option>
                        ${sum(option)}
                      </select>
                    </div>
                    <div class="input_name_box"></div>
                  </div>`
    
      return html;
    };

    //HTML挿入
    $('.menu_columns').append(addHTML());
    
  });

  //マイナスボタン
  $('body').on('click', '#menu-minus', function(){
    $(this).parent().parent().remove();
  });


});
