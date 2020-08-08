$(document).on('turbolinks:load', function(){
  $('body').on('change', '.input_form__column__protain', function () {
      var target = $(this).children().val();

      console.log(target)
  });
});