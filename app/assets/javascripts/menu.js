$(document).on('turbolinks:load', function(){
  $('.mass').on('change', function(){
    
    const mass = $(this).val();
    var id = $('#menu_name').val();

    function buildHTML(count) {
      var html =  `<div class='input_form__column__protain'> Protain
                    <p>${count.protain_rate * mass}</p>
                   </div>
                   <div class='input_form__column__fat'> Fat
                    <p>${count.fat_rate * mass}</p>
                   </div>
                   <div class='input_form__column__carbohydrate'> Carbohydrate
                    <p>${count.carbohydrate_rate * mass}</p>
                   </div>`
      return html;
    };
    
    $('.input_form__column__box').append(buildHTML(gon.food[(id - 1)]));

  });
});

