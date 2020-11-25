$(document).on('turbolinks:load', function(){
  if(document.URL.match(/sign_in/)){
    $('#easy_login').on('click', ()=>{
      $('#user_nickname').val('test-user');
      $('#user_email').val('test-user-calmania@gmail.com')
      $('#user_password').val('65oihue8')
      $('#login').click();
    });
  };
});