class Period < ActiveHash::Base
  self.data = [
    {id: 1, name: '毎日'}, {id: 2, name: '１日毎'}, {id: 3, name: '2日毎'}, {id: 4, name: '3日毎'}, {id: 5, name: '1週間毎'}
  ]
end
