$(document).on('turbolinks:load', function(){
  $('body').on('change', '#menu_name', function(){
    function massHTML(){
      var html = `<div class="label">
                    <p>Mass [g] :</p>
                    <input class="mass" id="menu_food" type="number" name="menu[food_mass]">
                  </div>`
      return html;
    };

    $(this).next().remove();
    $(this).parent().append(massHTML());
  });



  $('body').on('change', '#menu_food', function(){

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
    var foods = [];
    var masses = [];
    
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
                    <h2>Protain</h2>
                    <div class='input_form_warpper'>
                      <h3>${protain_cal}</h3><p> [kCal]</p>
                    </div>
                   </div>
                   <div class='input_form__column__box__fat'>
                    <h2>Fat</h2>
                    <div class='input_form_warpper'>
                      <h3>${fat_cal}</h3><p> [kCal]</p>
                    </div>
                   </div>
                   <div class='input_form__column__box__carbohydrate'>
                    <h2>Carbohydrate</h2>
                    <div class='input_form_warpper'>
                      <h3>${carbohydrate_cal}</h3><p> [kCal]</p>
                    </div>
                   </div>
                   <div class='input_form__column__box__total_mass'>
                    <h2>Total</h2>
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

    for(let j = 1; j < $('.input_form__column__box__protain').length + 1; j++){

      target_food = $('body, #menu_name')[j].value;
      target_mass = $('body, #menu_food')[j].value;
      
      if(target_food == ""){
        j += 1;
        target_food = $('body, #menu_name')[j].value;
        j -= 1;
      }
      
      foods.push(target_food);
      masses.push(target_mass);
    };

    function formHTML(){
      var html = `<input value="${foods}" type="hidden" name="menu[foods]" id="menu_foods"></input>
                  <input value="${masses}" type="hidden" name="menu[masses]" id="menu_masses"></input>
                  <input value="${Math.ceil(sum(protain)*10)/10}" type="hidden" name="menu[total_protain]" id="menu_total_protain"></input>
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
});

