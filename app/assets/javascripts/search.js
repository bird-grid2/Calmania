$(window).on('turbolinks:load', function (){

  var search_list = $(".upper-info");

  function appendMenu(menus) {

    var html =  `<table>
                  <tr>
                    <th class: "table-title">Menu</th>
                    <th class: "table-title">Mass [g]</th>
                    <th class: "table-title">Total Protain [kCal]</th>
                    <th class: "table-title">Total Fat [kCal]</th>
                    <th class: "table-title">Total Carb [kCal]</th>
                  </tr>
                  <tr>
                    <% ${menus}.each do |menu| %>
                      <td class: "table-item">
                        <%= menu.menu %>
                      </td>
                      <td class: "table-item">
                        <%= menu.masses.sum{ |num| num.to_i } %>
                      </td>
                      <td class: "table-item">
                        <%= menu.total_protain %>
                      </td>
                      <td class: "table-item">
                        <%= menu.total_fat %>
                      </td>
                      <td class: "table-item">
                        <%= menu.total_carbohydrate %>
                      </td>
                  </tr>
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
      } else {
        appendErrMsgToHTML("一致するメニューがありません");
      }
    })
    .fail(function() {
      alert('エラー');
    });
  });
});
