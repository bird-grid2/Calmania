$(document).on('turbolinks:load', function(){
  $('body').on('change', '#log_menus', function(){
    
    var id = $(this).val();
    var target = gon.menu[ id - 1 ]
    var protain = [];
    var fat = [];
    var carbo = [];
    var total = [];

    var sum  =(arr)=>{
      var sum = 0;
      arr.forEach((elm)=>{
          sum += elm;
      });
      Math.ceil(sum)
      return sum;
    };
    
    //カロリー表示HTMLの定義
    function appendHTML(log){
      var html = `<div class="show_protain">
                    <h2>タンパク質 合計</h2>
                    <div class="label">
                      <h3>${log.total_protain}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class="show_fat">
                    <h2>脂質 合計</h2>
                    <div class="label">
                      <h3>${log.total_fat}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class="show_carbohydrate">
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

    for(let i = 0; i < $('.show_protain').length; i++){
      p = Number($('.show_protain')[i].children[1].children[0].textContent);
      f = Number($('.show_fat')[i].children[1].children[0].textContent);
      c = Number($('.show_carbohydrate')[i].children[1].children[0].textContent);

      protain.push(Math.ceil(p * 10) / 10);
      fat.push(Math.ceil(f * 10) / 10);
      carbo.push(Math.ceil(c * 10) / 10);
      total.push(Math.ceil((p + f + c) * 10) / 10);
    };

    function addCalHTML(){
      var html = `<div class = 'show_calory--protain'>
                    <h2>タンパク質 合計</h2>
                    <div class= 'label'>
                      <h3>${Math.ceil(sum(protain) * 10) / 10}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class = "show_calory--fat">
                    <h2>脂質 合計</h2>
                    <div class= 'label'>
                      <h3>${Math.ceil(sum(fat) * 10) / 10}</h3> 
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class = "show_calory--carbohydrate">
                    <h2>炭水化物 合計</h2>
                    <div class= 'label'>
                      <h3>${Math.ceil(sum(carbo) * 10) / 10}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>
                  <div class = "show_calory--total">
                    <h2>総カロリー</h2>
                    <div class= 'label'>
                      <h3>${Math.ceil(sum(total) * 10) / 10}</h3>
                      <p>[kCal]</p>
                    </div>
                  </div>`
      return html;
    };

    
    $('.show_calory').empty();
    $('.show_calory').append(addCalHTML());
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
