$(document).on('turbolinks:load', function(){
  $('.mass').on('change', function(){
    
    const mass = $(this).val();
    var id = $('#menu_name').val();

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
    
    $('.input_form__column__box').append(buildHTML(gon.food[(id - 1)]));

  });
});

