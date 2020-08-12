$(document).on('turbolinks:load', function (){

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

  function appendMenu(menu) {

    var html =  `<table>
                  <tbody>
                    <tr>
                      <th class = "table-title">Menu</th>
                      <th class = "table-title">総重量 [g]</th>
                      <th class = "table-title">タンパク質 [kCal]</th>
                      <th class = "table-title">脂質 [kCal]</th>
                      <th class = "table-title">炭水化物 [kCal]</th>
                    </tr>
                    <tr>
                      <td class = "table-item">${menu.menu}</td>
                      <td class = "table-item">${sum(menu.masses)}</td>
                      <td class = "table-item">${menu.total_protain}</td>
                      <td class = "table-item">${menu.total_fat}</td>
                      <td class = "table-item">${menu.total_carbohydrate}</td>
                    </tr>
                  </tbody>
                </table>`

    search_list.append(html);
  }

  function appendErrMsgToHTML(msg) {
    var html = `<div class='name'>${ msg }</div>`
    search_list.append(html);
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
      if (menus.length !== 0) {
        menus.forEach(function(menu){
          appendMenu(menu);
        });
      }
      else {
        appendErrMsgToHTML("一致するメニューがありません");
      }
    })
    .fail(function() {
      alert('検索エラーです 管理者に連絡して下さい');
    });
  });
});

