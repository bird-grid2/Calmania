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
 現段階：menuページのサーバーサイド作業完了(編集・削除機能除く)
 - viewが完全に作成できていないので、まずはview作成
 - サーバーサイド作業(log, menu , graph , トップページ)
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
  - メニュー作成ページでインクリメンタルサーチできない
  - メニュー作成ページでマイナスボタン押すと、カロリー引き算できない(目星はついているので、後で実装予定)
  - menuページで、編集、削除機能が実装できていない(間に合えば実装予定)
  - 

# CaLmania DB設計

## usersテーブル
|Colmun|Type|Option|
|-------|----|------|
|nickname|string|null: false|
|password|string|null: false|
|height|double||
|weight|double||
|Protein_rate|double||
|Fat_rate|double||
|Carbohydrate_rate|double||
### Association
- has_many :managements
- has_many :logs

## managementsテーブル
|Colmun|Type|Option|
|-------|----|------|
|created_at|date|null: flase|
|body_mass_index|double||
|body_fat_parcentage|double||
|total_protain|integer||
|total_fat|integer||
|total_carbohydrate|integer||
|user|references|null: false, foreign_key: true|
|log|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :logs

## logsテーブル
|Colmun|Type|Option|
|-------|----|------|
|created_at|date|null: false|
|menu|string|null: false|

### Association
- belongs_to :user
- belongs_to :management
- has_many :logs_menus
- has_many :menus, thorough: :logs_menus

## logs_menusテーブル
|Column|Type|Options|
|------|----|-------|
|log|references|null: false, foreign_key: true|
|menu|references|null: false, foreign_key: true|
### Association
- belongs_to :log
- belongs_to :menu

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
- has_many :logs_menus
- has_many :logs, through: :logs_menus
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
