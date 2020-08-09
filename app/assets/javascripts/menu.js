$(document).on('turbolinks:load', function(){
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
    
    var sum  =(arr)=>{
      var sum = 0;
      arr.forEach((elm)=>{
          sum += elm;
      });
      return sum;
    };

    //PFCのカロリーを計算して、HTMLに追加する関数の定義
    function buildHTML(count) {
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
                      <h3>${protain_cal + fat_cal + carbohydrate_cal}</h3><p> [kCal]</p>
                    </div>
                  </div>`
      return html;
    };
    
    //表示のリセットとHTML追加
    $(this).parent().parent().parent().children().last().children().remove();
    $(this).parent().parent().parent().children().last().append(buildHTML(target));

    //計算結果のHTML定義
    function calcHTML(target) {
      var html = `<h3>${sum(target)}</h3><p> [kCal]</p>`
      return html;
    };

    //計算結果の挿入
    for(let i = 0; i < $('.input_form__column').length; i++){

      p = Number($('.input_form__column__box__protain')[i].children[1].children[0].textContent);
      f = Number($('.input_form__column__box__fat')[i].children[1].children[0].textContent);
      c = Number($('.input_form__column__box__carbohydrate')[i].children[1].children[0].textContent);

      protain.push(p);
      fat.push(f);
      carbohydrate.push(c);
      total.push((p + f + c))
    };

    
    $('.calculate_box__result--protain').children().remove();
    $('.calculate_box__result--protain').append(calcHTML(protain));
    $('.calculate_box__result--fat').children().remove();
    $('.calculate_box__result--fat').append(calcHTML(fat));
    $('.calculate_box__result--carbohydrate').children().remove();
    $('.calculate_box__result--carbohydrate').append(calcHTML(carbohydrate));
    $('.calculate_box__result--total').children().remove();
    $('.calculate_box__result--total').append(calcHTML(total));

  });
});

