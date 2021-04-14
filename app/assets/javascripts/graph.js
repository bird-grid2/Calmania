$(document).on('turbolinks:load', function(){
  if(document.URL.match(/graph/)){
    $(".graph_wrapper").empty();

    var html = `<div class="graph_upper">
                  <div class="left_graph">
                    <img src="/assets/test_${gon.user_id}.png">
                  </div>
                  <div class="right_graph">
                    <img src="/assets/test_${gon.user_id}_1.png">
                  </div>
                </div>
                <div class="graph_bottom">
                  <div class="left_graph">
                    <img src="/assets/test_${gon.user_id}_2.png">
                  </div>
                  <div class="right_graph">
                    <img src="/assets/test_${gon.user_id}_3.png">
                  </div>
                </div>`

    $(".graph_wrapper").append(html);
  };
});