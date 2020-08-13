# Name
 Calmania

# features
- 1日の摂取カロリーを計算・記録
- 体重・体脂肪・BMIの推移グラフ
- メニューの作成
- 理想的な減量方法の提示(1日の削減カロリーを任意に決める)

# background
 去年の自分が減量しましたが、自分が考える方法でアプリが作られていなかった。  
 不足させるカロリーを計算するために、スプレッドシートで管理してい為、面倒だった。  
 スプレッドシートのupgrade版を実装する為、作成いたしました。
 
# update information
 現段階: トップページのサーバーサイド作業完了(BMI表示は除く)
 - viewが完全に作成できていないので、まずはview作成
 - サーバーサイド作業(user, graph)
 - graph情報の更新(x軸 , y軸, jsonで非同期通信)

# DEMO
 #### メニュー機能
  - カロリー計算
   ![カロリー計算](https://user-images.githubusercontent.com/61616172/89990301-1eaff880-dcbd-11ea-9151-1cc8f4083744.gif)
  - メニュー作成
   ![メニュー作成](https://user-images.githubusercontent.com/61616172/89990346-35564f80-dcbd-11ea-854a-72683b7a5f0c.gif)
  - インクリメンタルサーチ
   ![インクリ](https://user-images.githubusercontent.com/61616172/89992424-389f0a80-dcc0-11ea-9de7-1d78862cff1e.gif)


# problem
  - メニュー・ログ作成ページでインクリメンタルサーチできない
  - メニュー・ログ作成ページでマイナスボタン押すと、カロリー引き算できない(目星はついているので、後で実装予定)
  - メニュー・ログ作成ページで編集、削除機能が実装できていない(間に合えば実装予定)

# CaLmania DB設計

## usersテーブル
|Colmun|Type|Option|
|-------|----|------|
|nickname|string|null: false|
|password|string|null: false|
|height|double||
|ideal_protain_rate|double||
|ideal_fat_rate|double||
|ideal_carbohydrate_rate|double||
### Association
- has_many :logs, dependent: :destroy

## logsテーブル
|Colmun|Type|Option|
|-------|----|------|
|date|date|null: false|
|weight|decimal|precision: 4, scale: 1|
|bfp|decimal|precision: 3, scale: 1|
|total_cal|decimal|precision: 5, scale: 1|
|description|text||
|menu_numbers|string|array: true|
|user|references|foreign_key: true, on_delete: :cascade|
### Association
- belongs_to :user
- has_many :menus

## menusテーブル
|Colmun|Type|Option|
|-------|----|------|
|menu|string|null: false|
|names|string|array: true, null: false|
|masses|string|array: true, null: false|
|total_protain|decimal|precision: 5, scale: 1|
|total_fat|decimal|precision: 5, scale: 1|
|total_carbohydrate|decimal|precision: 5, scale: 1|
### Association
- belongs_to :log
- has_many :foods

## foodsテーブル
|Colmun|Type|Option|
|-------|----|------|
|food|string|null: false|
|protain|double|null: false|
|fat|double|null: false|
|carbohydrate|double|null: false|
### Associtaion
- belongs_to :menu
