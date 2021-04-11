$(document).on('turbolinks:load', function(){
  if(document.URL.match(/graph/)){
    var html = `<div class="graph_upper">
                  <div class="left_graph">
                    <img src="test.png">
                  </div>
                  <div class="right_graph">
                    <img src="test_1.png">
                  </div>
                </div>
                <div class="graph_bottom">
                  <div class="left_graph">
                    <img src="test_2.png">
                  </div>
                  <div class="right_graph">
                    <img src="test_3.png">
                  </div>
                </div>`

    $(".graph_wrapper").empty();
    $(".graph_wrapper").append(html);
  };
});