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
    var sum  = (arr)=>{
      var sum = 0;
      arr.forEach((elm)=>{
          sum += elm;
      });
      return sum;
    };

    //PFCのカロリーを計算して、HTMLに追加する関数の定義
    function buildHTML(count) {
      var html =  `<div class='input_form__column__protain'> Protain
                    <p>${protain_cal} [kCal]</p>
                   </div>
                   <div class='input_form__column__fat'> Fat
                    <p>${fat_cal} [kCal]</p>
                   </div>
                   <div class='input_form__column__carbohydrate'> Carbohydrate
                    <p>${carbohydrate_cal} [kCal]</p>
                   </div>
                   <div class='input_form__column__total_mass'> Total
                   <p>${protain_cal + fat_cal + carbohydrate_cal} [kCal]</p>
                  </div>`
      return html;
    };
    
    //表示のリセットとHTML追加
    $(this).parent().parent().parent().children().last().children().remove();
    $(this).parent().parent().parent().children().last().append(buildHTML(target));

    //それぞれの成分を配列に挿入
    protain.push(protain_cal);
    fat.push(fat_cal);
    carbohydrate.push(carbohydrate_cal);

    console.log(protain)

    //計算結果のHTML定義
    function calcHTML(target) {
      var html = `<p> ${sum(target)} [kCal]</p>`
      return html;
    };

    //計算結果の挿入
    $('.calculate_box--protain').children().remove();
    $('.calculate_box--protain').append(calcHTML(protain));

    $('.calculate_box--fat').children().remove();
    $('.calculate_box--fat').append(calcHTML(fat));

    $('.calculate_box--carbohydrate').children().remove();
    $('.calculate_box--carbohydrate').append(calcHTML(carbohydrate));

  });
});

