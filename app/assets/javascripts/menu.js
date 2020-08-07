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

    function addHTML() {
      var html = `<div class= 'input_form__column__input_name'>
                    <%= form.collection_select :name, @foods, :id, :food, prompt: '選択してください' %>
                    <div class= 'label'>
                      <p> Mass [g] :</p> 
                      <%= form.text_area :food_mass, class: 'mass' %>
                    </div>
                  </div>
                  <div class= 'input_form__column__box'>
                  </div>`
      return html;
    }
    
    $('.input_form__column__box').append(buildHTML(gon.food[(id - 1)]));

    $('.input_form__column').append(addHTML());

  });
});

