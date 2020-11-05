$(document).on('turbolinks:load', function (){
  if(document.URL.match(/logs/)){

    var search_list = $(".upper-info");

    function appendTable(){
      var html =  `<table>
                    <tbody>
                      <tr>
                        <th class = "table-icon"></th>
                        <th class = "table-title">記録</th>
                        <th class = "table-title">体重 [kg]</th>
                        <th class = "table-title">体脂肪率 [%]</th>
                        <th class = "table-title">総カロリー [kCal]</th>
                        <th class = "table-title">コメント</th>
                      </tr>
                    </tbody>
                  </table>`
      
      search_list.append(html);
    }

    function appendLog(log) {

      var html =  `<tr>
                    <td class="table-icon"><a href="logs/1/edit"><i class="fas fa-edit"></i></a>
                    <span></span>
                    <a data-confirm="本当に削除しますか?" rel="nofollow" data-method="delete" href="logs/1"><i class="fas fa-trash-alt"></i></a></td>
                    <td class = "table-item">${log.date}</td>
                    <td class = "table-item">${log.height}</td>
                    <td class = "table-item">${log.bfp}</td>
                    <td class = "table-item">${log.total_cal}</td>
                    <td class = "table-item">${log.description}</td>
                  </tr>`

      $("tbody").append(html);
    }

    function appendErrMsgToHTML(msg) {
      var html = `<div class='name'>${ msg }</div>`
      search_list.append(html);
    }

    $(".search-input").on("keyup", function() {
      var input = $(".search-input").val();
      
      $.ajax({
        type: 'GET',
        url: '/logs/log_search',
        data: { keyword: input },
        dataType: 'json'
      })
      .done(function(logs) {
        search_list.empty();
        appendTable();
        if (logs.length !== 0) {
          logs.forEach(function(log){
            appendLog(log);
          });
        }
        else {
          search_list.children().children().empty();
          appendErrMsgToHTML("一致するログがありません");
        }
      })
      .fail(function() {
        alert('検索エラーです 管理者に連絡して下さい');
      });
    });
  };
});

