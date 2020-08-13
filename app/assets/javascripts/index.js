$(document).on('turbolinks:load', function(){

  function appendErrMsgToHTML(msg) {
    var html = `<div class='name'>${ msg }</div>`
    $('.middle-managements__right-contents').append(html);
  };
  
  if(gon.today.blank?){
    $('.middle-managements__right-contents').empty();

    appendErrMsgToHTML("今日はまだ記録していません");
  }
});