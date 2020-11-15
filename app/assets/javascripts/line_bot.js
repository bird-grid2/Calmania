var  ACCESS_TOKEN = ENV["LINE_ACCESS_TOKEN"];

function broadcast() {
  UrlFetchApp.fetch('https://api.line.me/v2/bot/message/broadcast', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + ACCESS_TOKEN,
    },
    payload: JSON.stringify({
      messages: [
        {
            type: 'text',
            text: '時間になりました。</br>定期入力の時間です。'
        },
      ]
    }),
  });
}