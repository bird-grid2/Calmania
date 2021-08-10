$(document).on('turbolinks:load', function(){
  if(document.URL.match(/menus/)){
    



    $('body').on('change', '#menu_masses', function(){

    //式の定義
      var mass = $(this).val();
      var id = $(this).parent().parent().children().val();
      var target = gon.food[(id - 1)];
      var protain_cal = Math.ceil(target.protain_rate * mass * 4)/10;
      var fat_cal = Math.ceil(target.fat_rate * mass * 9)/10;
      var carbohydrate_cal = Math.ceil(target.carbohydrate_rate * mass * 4)/10
      var protain = [];
      var fat = [];
      var carbohydrate = [];
      var total = [];
      
      var sum  =(arr)=>{
        var sum = 0;
        arr.forEach((elm)=>{
            sum += elm;
        });
        (Math.ceil(sum) * 10) / 10;
        return sum;
      };

      //PFCのカロリーを計算して、HTMLに追加する関数の定義
      function buildHTML() {
        var html =  `<div class='input_form__column__box__protain'> 
                      <h2>タンパク質</h2>
                      <div class='input_form_warpper'>
                        <h3>${protain_cal}</h3><p> [kCal]</p>
                      </div>
                    </div>
                    <div class='input_form__column__box__fat'>
                      <h2>脂質</h2>
                      <div class='input_form_warpper'>
                        <h3>${fat_cal}</h3><p> [kCal]</p>
                      </div>
                    </div>
                    <div class='input_form__column__box__carbohydrate'>
                      <h2>炭水化物</h2>
                      <div class='input_form_warpper'>
                        <h3>${carbohydrate_cal}</h3><p> [kCal]</p>
                      </div>
                    </div>
                    <div class='input_form__column__box__total_mass'>
                      <h2>総カロリー</h2>
                      <div class='input_form_warpper'>
                        <h3>${Math.ceil((protain_cal + fat_cal + carbohydrate_cal) * 10) / 10}</h3><p> [kCal]</p>
                      </div>
                    </div>`
        return html;
      };
      
      //表示のリセットとHTML追加
      $(this).parent().parent().parent().children().last().children().remove();
      $(this).parent().parent().parent().children().last().append(buildHTML());

      //計算結果のHTML定義
      function calcHTML(target) {
        var html = `<h3>${Math.ceil(sum(target) * 10)/10}</h3><p> [kCal]</p>`
        return html;
      };


      //計算結果の挿入
      for(let i = 0; i < $('.input_form__column__box__protain').length; i++){

        p = Number($('.input_form__column__box__protain')[i].children[1].children[0].textContent);
        f = Number($('.input_form__column__box__fat')[i].children[1].children[0].textContent);
        c = Number($('.input_form__column__box__carbohydrate')[i].children[1].children[0].textContent);

        protain.push(p);
        fat.push(f);
        carbohydrate.push(c);
        total.push((p + f + c))
      };

      function formHTML(){
        var html = `<input value="${Math.ceil(sum(protain)*10)/10}" type="hidden" name="menu[total_protain]" id="menu_total_protain"></input>
                    <input value="${Math.ceil(sum(fat)*10)/10}" type="hidden" name="menu[total_fat]" id="menu_total_fat"></input>
                    <input value="${Math.ceil(sum(carbohydrate)*10)/10}" type="hidden" name="menu[total_carbohydrate]" id="menu_total_carbohydrate"></input>`
        return html;
      }

      
      $('.calculate_box__result--protain').children().remove();
      $('.calculate_box__result--protain').append(calcHTML(protain));
      $('.calculate_box__result--fat').children().remove();
      $('.calculate_box__result--fat').append(calcHTML(fat));
      $('.calculate_box__result--carbohydrate').children().remove();
      $('.calculate_box__result--carbohydrate').append(calcHTML(carbohydrate));
      $('.calculate_box__result--total').children().remove();
      $('.calculate_box__result--total').append(calcHTML(total));
      $('.calculate_box__result--form').children().remove();
      $('.calculate_box__result--form').append(formHTML());
    });

    $('body').on('click', '#menu-plus', function(){

      var sum  =(arr)=>{
        var sum = 0;
        arr.forEach((elm)=>{
            sum += elm;
        });
        return sum;
      };
  
      option = []
        
      //foodデータの取得
      gon.food.forEach((food)=>{
        var html = `<option value="${food.id}">${food.element}</option>`
        option.push(html);
      });

      num = $('input_form__column').length - 1;
  
      function addHTML() {
        var html =  `<div class="input_form__column">
                      <div class="input_form__column__label">
                        <i class="fas fa-plus-circle icon" id="menu-plus"></i>
                        <i class="fas fa-minus-circle icon" id="menu-minus"></i>
                      </div>
                      <div class="input_form__column__input_name_${num}" id='name'>
                        <select name="menu[names][]" id="menu_names">
                          <option value="">選択してください</option>
                          ${sum(option)}
                        </select>
                      </div>
                      <div class='input_form__column__box_${num}' id='fbox'>
                      </div>
                    </div>`
        return html;
      };
    
      $('.input_form').append(addHTML());    
    
    });
  
    //マイナスボタンの処理
    $('body').on('click', '#menu-minus', function(){

      //何もしなければ、普通に消す or 引き算処理
      if($(this).parent().next().children()[0].value == "" || $(this).parent().next().children().next().children().next()[0].value == ""){
        $(this).parent().parent().remove();
      }else{
        target =  $(this).parent().next().next().children();
        protain = Number(target[0].children[1].children[0].textContent);
        fat = Number(target[1].children[1].children[0].textContent);
        carb = Number(target[2].children[1].children[0].textContent);
        total = protain + fat + carb;

        refer_p = Number($('.calculate_box__result--protain').children()[0].textContent);
        refer_f = Number($('.calculate_box__result--fat').children()[0].textContent);
        refer_c = Number($('.calculate_box__result--carbohydrate').children()[0].textContent);
        refer_t = refer_p + refer_f + refer_c

        refer_p = refer_p - protain;
        refer_f = refer_f - fat;
        refer_c = refer_c - carb;
        refer_t = refer_t - total; 

        $('.calculate_box__result--protain').children()[0].textContent = Math.ceil(refer_p * 10) /10;
        $('.calculate_box__result--fat').children()[0].textContent = Math.ceil(refer_f * 10) / 10;
        $('.calculate_box__result--carbohydrate').children()[0].textContent = Math.ceil(refer_c * 10) / 10;
        $('.calculate_box__result--total').children()[0].textContent = Math.ceil(refer_t * 10) / 10;

        function formHTML(){
          var html = `<input value="${Math.ceil(refer_p * 10)/10}" type="hidden" name="menu[total_protain]" id="menu_total_protain"></input>
                      <input value="${Math.ceil(refer_f * 10)/10}" type="hidden" name="menu[total_fat]" id="menu_total_fat"></input>
                      <input value="${Math.ceil(refer_c * 10)/10}" type="hidden" name="menu[total_carbohydrate]" id="menu_total_carbohydrate"></input>`
          return html;
        }
        $('.calculate_box__result--form').children().remove();
        $('.calculate_box__result--form').append(formHTML());
        $(this).parent().parent().remove();
      };
    });
  };
});

