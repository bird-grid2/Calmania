$(document).on('turbolinks:load', function(){
  $('body').on('change', '#menu_food', function(){

   //式の定義
    var mass = $(this).val();
    var id = $(this).parent().parent().children().val();
    var target = gon.food[(id - 1)];
    var protain = [];
    var fat = [];
    var carbohydrate = [];

    //PFCのカロリーを計算して、HTMLに追加する関数の定義
    function buildHTML(count) {
      var html =  `<div class='input_form__column__protain'> Protain
                    <p>${Math.ceil(count.protain_rate * mass * 4)/10} [kCal]</p>
                   </div>
                   <div class='input_form__column__fat'> Fat
                    <p>${Math.ceil(count.fat_rate * mass * 9)/10} [kCal]</p>
                   </div>
                   <div class='input_form__column__carbohydrate'> Carbohydrate
                    <p>${Math.ceil(count.carbohydrate_rate * mass * 4)/10} [kCal]</p>
                   </div>
                   <div class='input_form__column__total_mass'> Total
                   <p>${Math.ceil((count.protain_rate * mass * 4) + (count.fat_rate * mass * 9) + (count.carbohydrate_rate * mass * 4))/10} [kCal]</p>
                  </div>`
      return html;
    };
    
    //表示のリセットとHTML追加
    $(this).parent().parent().parent().children().last().children().remove();
    $(this).parent().parent().parent().children().last().append(buildHTML(target));

    //それぞれの成分を配列に挿入
    protain.append(Math.ceil(target.protain_rate * mass * 4)/10);
    fat.append(Math.ceil(target.fat_rate * mass * 9)/10);
    carbohydrate.append(Math.ceil(target.carbohydrate_rate * mass * 4)/10);

    //計算結果のHTML定義
    function calcHTML(target) {
      var html = `<p> ${sum(target)} [kCal]</p>`
    };

    //計算結果の挿入
    $('.calculate_box--protain').children().remove();
    $('.calculate_box--protain').children().append(calcHTML(protain));

    $('.calculate_box--fat').children().remove();
    $('.calculate_box--fat').children().append(calcHTML(fat));

    $('.calculate_box--carbohydrate').children().remove();
    $('.calculate_box--carbohydrate').children().append(calcHTML(carbohydrate));

  });
});

