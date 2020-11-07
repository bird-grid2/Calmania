$(document).on('turbolinks:load', function (){
  if(document.URL.match(/logs/)){

    var search_list = $(".upper-info");

    function appendTable(){
      var html =  `<table>
                    <tbody>
                      <tr>
                        <th class = "table-icon"></th>
                        <th class = "table-title">記録日</th>
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

      if(log.height = 'undefined'){
        target_1 = '';
      } else if(log.bfp = '') {
        target_2 = '---';
      } else if(log.description = '') {
        target_3 = '---';
      } else {
        target_1 = log.height;
        target_2  = log.bfp;
        target_3 = log.description;
      }

      var html =  `<tr>
                    <td class="table-icon"><a href="logs/1/edit"><i class="fas fa-edit"></i></a>
                    <span></span>
                    <a data-confirm="本当に削除しますか?" rel="nofollow" data-method="delete" href="logs/1"><i class="fas fa-trash-alt"></i></a></td>
                    <td class = "table-item">${log.date}</td>
                    <td class = "table-item">${target_1}</td>
                    <td class = "table-item">${target_2}</td>
                    <td class = "table-item">${log.total_cal}</td>
                    <td class = "table-item">${target_3}</td>
                  </tr>`

      $("tbody").append(html);
    }

    function appendErrMsgToHTML(msg) {
      var html = `<div class='name'>${ msg }</div>`
      search_list.children().children().append(html);
    }

    $(".search-input").on("keyup", function() {
      var input = $(".search-input").val();
      
      $.ajax({
        type: 'GET',
        url: '/logs/search',
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
          search_list.empty();
          appendTable();
          appendErrMsgToHTML("一致するログがありません");
        }
      })
      .fail(function() {
        alert('検索エラーです 管理者に連絡して下さい');
      });
    });
  };
});

