import backGroundService from '../../../service/background.service'

let protainData = 0;
let fatData = 0;
let carboData = 0;

function sendData(data) {
  backGroundService.getEditFoodsBoard(data)
  .then( res => {
    protainData = res.data.protain_rate
    fatData = res.data.fat_rate
    carboData = res.data.carbohydrate_rate
    console.log('abc')
  })
  .catch( error => { console.log(error) } )
  return { protainData, fatData, carboData }
}

export default {
  sendData
}
