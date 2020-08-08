$(document).on('turbolinks:load', function(){
  $('body').on('change', '#menu_food', function(){

    var mass = $(this).val();
    var id = $(this).parent().parent().children().val();

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
    
    $(this).parent().parent().parent().children().last().children().remove();
    $(this).parent().parent().parent().children().last().append(buildHTML(gon.food[(id - 1)]));

  });
});

