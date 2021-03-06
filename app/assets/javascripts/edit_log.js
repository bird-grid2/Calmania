$(document).on('turbolinks:load', function(){
  if(document.URL.match(/logs...edit/)){

    var option = [];
    var protain = [];
    var fat = [];
    var carbo = [];
    var total = []; 
    
    var sum  = function(arr){
      var sum = 0;
      arr.forEach(function(elm){
          sum += elm;
      });
      Math.ceil(sum)
      return sum;
    };

    $('.menu_columns').empty();

    $.each(gon.edit, (index, target)=>{

      var id = gon.menu[ target - 1 ];

      //選択済みのmenuデータの取得
      gon.menu.forEach((menu)=>{
          
        if(menu.id == target){
          var menuhtml = `<option value="${menu.id}" selected>${menu.material}</option>`;  
        }else{
          var menuhtml = `<option value="${menu.id}">${menu.material}</option>`
        }  
        option.push(menuhtml);
      });

      if(index == 0){
        //挿入するHTMLの定義
        function addHTML(){

          var html = `<div class="menu_columns__col">
                        <div class="menu_columns__col__label">
                          <i class="fas fa-plus-circle icon" id="menu-plus"></i>
                        </div>
                        <div class="input_name">
                          <select name="log[menu_numbers][]" id="log_menu_numbers"><option value="">メニューを選択して下さい</option>
                            ${sum(option)}
                          </select>
                        </div>
                        <div class="input_name_box_0", id='box'></div>
                      </div>`
        
          return html;
        };
      }else{
        function addHTML(){

          var html = `<div class="menu_columns__col">
                        <div class="menu_columns__col__label">
                          <i class="fas fa-plus-circle icon" id="menu-plus"></i>
                          <i class="fas fa-minus-circle icon" id="menu-minus"></i>
                        </div>
                        <div class="input_name">
                          <select name="log[menu_numbers][]" id="log_menu_numbers"><option value="">メニューを選択して下さい</option>
                            ${sum(option)}
                          </select>
                        </div>
                        <div class="input_name_box_${index}", id='box'>
                        </div>
                      </div>`
        
          return html;
        };
      }

      $('.menu_columns').append(addHTML());

      //カロリー表示HTMLの定義
      function appendHTML(log){
        var loghtml = `<div class="show_protain">
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
        return loghtml;
      };

      $('body .input_name_box_' + index).append(appendHTML(id));
    });

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

    function formHTML(){
      var html = `<input value="${Math.ceil(sum(total) * 10 ) / 10}" type="hidden" name="log[total_cal]" id="log_total_cal"></input>`
      return html;
    };
    
    $('.show_calory').append(formHTML());

    $('.btn')[0].value = 'ログ更新'; 
  };
});