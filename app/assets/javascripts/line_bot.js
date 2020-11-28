
$(document).on('turbolinks:load', function(){
  if(document.URL.match(/users\/edit/)){
    $('#edit_submit').on('click', ()=>{
      var url = "https://calmania.work/broadcast"
      var request = createXMLHttpRequest();
      request.open("POST", url, true);
      request.send("");
      console.log("ok")
    });
  };
});