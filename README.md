# Name
 Calmania

# Description
  減量する為には、計画的な摂取カロリーのコントロールが必要です。  
  成分表がついている料理がコンビニ商品等の一部な為、計画的なカロリー摂取が難しい。  
  厚労省の成分表を元にデータを構成し、料理のカロリーを表示しやすいようにしました。  


# Access
ご覧は[こちら](https://calmania.herokuapp.com/)になります。  
かんたんログインをご利用ください。  
※セキュリティ上、個人情報は入力しないでください。  
 ダミーのメールアドレスで登録可能です。  

# background
 去年の自分が減量しましたが、自分が考える方法でアプリが作られていなかった。  
 不足させるカロリーを計算するために、スプレッドシートで管理してい為、面倒だった。  
 スプレッドシートのupgrade版を実装する為、作成いたしました。  
 肥満は現代病であり、いつでも健康でいる事はとても大事です。  
 自分が、減量成功していますので、減量方法の一つのやり方を提示したいと考えました。  

# DEMO
 #### メニュー機能
  - カロリー計算
   ![カロリー計算](https://user-images.githubusercontent.com/61616172/89990301-1eaff880-dcbd-11ea-9151-1cc8f4083744.gif)
  - メニュー作成
   ![メニュー作成](https://user-images.githubusercontent.com/61616172/89990346-35564f80-dcbd-11ea-854a-72683b7a5f0c.gif)
  - インクリメンタルサーチ
   ![インクリ](https://user-images.githubusercontent.com/61616172/89992424-389f0a80-dcc0-11ea-9de7-1d78862cff1e.gif)


# features
- 1日の摂取カロリーを計算・記録
- 体重・体脂肪・BMIの推移グラフ
- メニューの作成

# Environment
  Ruby 2.5.1  
  Rails 5.2.4.3  
  jQuery-rails 4.4.0  
  Python 3.8.5  
  Pycall 1.3.1  


# update information
 - graph情報の更新(ウィンドウの表示)
 - PFCバランスで摂取カロリー表示
 - できれば、目標の線図を搭載
 - 機械学習の要素を追加したい

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
|target_cal|integer||
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
