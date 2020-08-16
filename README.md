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
 - graph情報の更新(ウィンドウの表示)
 - PFCバランスで摂取カロリー表示
 - できれば、目標の線図を搭載

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
  - メニューのviewページでインクリメンタルサーチできない
  - 引き算はできるが、floatのため誤差が生じる

# CaLmania DB設計

## usersテーブル
|Colmun|Type|Option|
|-------|----|------|
|nickname|string|null: false|
|email|string|null: false, defalult: ""|
|encrypted_password|string|null: false, default: ""|
|height|decimal|precision: 4, scale: 1|
|ideal_protain_rate|integer||
|ideal_fat_rate|integer||
|ideal_carbohydrate_rate|integer||
｜target＿cal｜integer｜｜
### Association
- has_many :logs, dependent: :destroy
- validates :nickname, presence: true, uniqueness: true

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
- belongs_to :log, optional: true
- has_many :foods

## foodsテーブル
|Colmun|Type|Option|
|-------|----|------|
|food|string|null: false|
|protain_rate|decimal|null: false, precision: 6, scale: 5|
|fat_rate|decimal|null: false, precision: 6, scale: 5|
|carbohydrate_rate|decimal|null: false, precision: 6, scale: 5|
### Associtaion
- belongs_to :menu
