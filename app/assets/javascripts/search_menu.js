$(document).on('turbolinks:load', function (){
  if(document.URL.match(/menus/)){

    var sum  =(arr)=>{
      var sum = 0;
      arr.forEach((elm)=>{
        elm = Number(elm)  
        sum += elm;
      });
      Math.ceil(sum);
      return sum;
    };

    var search_list = $(".upper-info");

    function appendTable(){
      var html =  `<table>
                    <tbody>
                      <tr>
                        <th class = "table-icon"></th>
                        <th class = "table-title">Menu</th>
                        <th class = "table-title">総重量 [g]</th>
                        <th class = "table-title">タンパク質 [kCal]</th>
                        <th class = "table-title">脂質 [kCal]</th>
                        <th class = "table-title">炭水化物 [kCal]</th>
                      </tr>
                    </tbody>
                  </table>`
      
      search_list.append(html);
    }

    function appendMenu(menu) {

      var html =  `<tr>
                    <td class="table-icon">
                    <a href="menus/1/edit"><i class="fas fa-edit"></i></a>
                    <span></span>
                    <a data-confirm="本当に削除しますか?" rel="nofollow" data-method="delete" href="menus/1"><i class="fas fa-trash-alt"></i></a></td>
                    <td class = "table-item">${menu.material}</td>
                    <td class = "table-item">${sum(menu.masses)}</td>
                    <td class = "table-item">${menu.total_protain}</td>
                    <td class = "table-item">${menu.total_fat}</td>
                    <td class = "table-item">${menu.total_carbohydrate}</td>
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
        url: '/menus/search',
        data: { keyword: input },
        dataType: 'json'
      })
      .done(function(menus) {
        search_list.empty();
        appendTable();
        if (menus.length !== 0) {
          menus.forEach(function(menu){
            appendMenu(menu);
          });
        }
        else {
          search_list.empty();
          appendTable();
          appendErrMsgToHTML("一致するメニューがありません");
        }
      })
      .fail(function() {
        alert('検索エラーです 管理者に連絡して下さい');
      });
    });
  };
});

