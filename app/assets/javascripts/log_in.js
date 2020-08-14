$(document).on('turbolinks:load', function(){
  if(document.URL.match(/sign_in/)){
    $('#easy_login').on('click', ()=>{
      $('#user_nickname').val('duo');
      $('#user_email').val('aaaaaa@gmail.com')
      $('#user_password').val('123456')
      $('#login').click();
    });
  };
});