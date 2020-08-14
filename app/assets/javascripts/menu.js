$(document).on('turbolinks:load', function(){
  if(document.URL.match(/menus/)){
    $('body').on('change', '#menu_names', function(){
      function massHTML(){
        var html = `<div class="label">
                      <p>重量 [g] :</p>
                      <input class="mass" id="menu_masses" type="number" name="menu[masses][]">
                    </div>`
        return html;
      };

      $(this).next().remove();
      $(this).parent().append(massHTML());
    });



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
                      <h2>タンパク質</h2>
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
        var html = `<option value="${food.id}">${food.food}</option>`
        option.push(html);
      });
  
      function addHTML() {
        var html =  `<div class="input_form__column">
                      <div class="input_form__column__label">
                        <i class="fas fa-plus-circle icon" id="menu-plus"></i>
                        <i class="fas fa-minus-circle icon" id="menu-minus"></i>
                      </div>
                      <div class="input_form__column__input_name">
                        <select name="menu[names][]" id="menu_names">
                          <option value="">選択してください</option>
                          ${sum(option)}
                        </select>
                      </div>
                      <div class='input_form__column__box'>
                      </div>
                    </div>`
        return html;
      };
    
      $('.input_form').append(addHTML());    
    
    });
  
    $('body').on('click', '#menu-minus', function(){
      $(this).parent().parent().remove();
    });
  };
});

