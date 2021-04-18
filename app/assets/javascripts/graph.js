$(document).on('turbolinks:load', function(){
  if(document.URL.match(/graph/)){
    if(window.name != "reload"){
      window.location.reload();
      window.name = "reload"
    }else{
      window.name = ""
    }
  };
});