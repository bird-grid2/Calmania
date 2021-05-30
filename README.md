
# Description
  減量する為には、計画的な摂取カロリーのコントロールが必要です。  
  成分表がついている料理がコンビニ商品等の一部な為、計画的なカロリー摂取が難しい。  
  厚労省の成分表を元にデータを構成し、料理のカロリーを表示しやすいようにしました。  

# Access
ご覧は[こちら](https://calmania.work/)になります。  
かんたんログインをご利用ください。      

# features
- 1日の摂取カロリーを計算・記録
- 体重・体脂肪・BMIの推移グラフ
- メニューの作成

# Environment

  Ruby 2.5.1  
  Rails 5.2.4.3  
  jQuery-rails 4.4.0  
  Pycall 1.3.1  
  AWS(Route53、VPC、EC2、ELB、RDS)  
  CircleCI  
  Mergify  
  
<img width="600" alt="infra" src="https://user-images.githubusercontent.com/61616172/95674018-7351f000-0be8-11eb-9034-29247a0c2c10.png">

# update information
 ★ graph情報の更新(ウィンドウの表示)  
 ★ PFCバランスで摂取カロリー表示  
 ★ できれば、目標の線図を搭載  
 ★ 機械学習の要素を追加したい  

# problem
  - メニュー・ログ作成ページでインクリメンタルサーチできない
  - 引き算はできるが、floatのため誤差が生じる
  - ジョブを自動で削除できない

# Calmania DB設計

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
- validates :encrypted_password, presence: true
- validates :height, :ideal_protain_rate, :ideal_fat_rate, :ideal_carbohydrate_rate, :target_cal, numericality: { allow_nil: true }

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
- validates :date, :user_id, presence: true
- validates :weight, :bfp, :total_cal, numericality: { allow_nil: true }

## menusテーブル
|Colmun|Type|Option|
|-------|----|------|
|material|string|null: false|
|names|string|array: true, null: false|
|masses|string|array: true, null: false|
|total_protain|decimal|precision: 5, scale: 1|
|total_fat|decimal|precision: 5, scale: 1|
|total_carbohydrate|decimal|precision: 5, scale: 1|
### Association
- belongs_to :log, optional: true
- has_many :foods
- validates :material, :names, :masses, presence: true

## foodsテーブル
|Colmun|Type|Option|
|-------|----|------|
|element|string|null: false|
|protain_rate|decimal|null: false, precision: 6, scale: 5|
|fat_rate|decimal|null: false, precision: 6, scale: 5|
|carbohydrate_rate|decimal|null: false, precision: 6, scale: 5|
### Associtaion
- belongs_to :menu
- validates :element, :protain_rate, :fat_rate, :carbohydrate_rate, presence: true