$(document).on('turbolinks:load', function(){
  if(document.URL.match(/graph/)){
    var html = `<div class="graph_upper">
                  <div class="left_graph">
                    <img src="/assets/test.png">
                  </div>
                  <div class="right_graph">
                    <img src="/assets/test_1.png">
                  </div>
                </div>
                <div class="graph_bottom">
                  <div class="left_graph">
                    <img src="/assets/test_2.png">
                  </div>
                  <div class="right_graph">
                    <img src="/assets/test_3.png">
                  </div>
                </div>`

    $(".graph_wrapper").append(html);
  };
});