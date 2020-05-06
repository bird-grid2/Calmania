# README

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
|mass|double|null: false|
### Association
- has_many :logs_menus
- has_many :logs, through: :logs_menus
- has_many :menus_foods
- has_many :foods, through: :menus_foods

## menus_foodsテーブル
|Column|Type|Options|
|------|----|-------|
|menu|references|null: false, foreign_key: true|
|food|references|null: false, foreign_key: true|
### Association
- belongs_to :food
- belongs_to :management

## foodsテーブル
|Colmun|Type|Option|
|-------|----|------|
|food|string|null: false|
|protain|double|null: false|
|fat|double|null: false|
|carbohydrate|double|null: false|
### Associtaion
- has_many :menus_foods
- has_many :menus, through: :menus_foods

