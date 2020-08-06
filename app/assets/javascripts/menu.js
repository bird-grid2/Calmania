$(document).on('turbolinks:load', function(){
  $('#menu_name').on('change', function(){
    var id = $(this).val()
    var food = Food.find(id)

    console.log(food)
    
    
    
    $(this).append(buildHTML(id))

  })

});

function buildHTML(count) {
  var html =  `<div class='input_form__column__protain'>
                <p>${count.prtotain_rate}</p>
               </div>
               <div class='input_form__column__fat'>
                <p>${count.fat_rate}</p>
               </div>
               <div class='input_form__column__carbohydrate'>
                <p>${count.carbohydrate_rate}</p>
               </div>`
  return html;
};