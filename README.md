# README

# CaLmania DB設計

## usersテーブル
|Colmun|Type|Option|
|-------|----|------|
|nickname|string|null: false|
|password|string|null: false|
|height|integer||
|weight|integer||
|Protein_rate|integer||
|Fat_rate|integer||
|Carbohydrate_rate|integer||
### Association
- Has_many :managements

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
- Has_many :logs

## logsテーブル
|Colmun|Type|Option|
|-------|----|------|
|created_at|date|null: false|
|menu|string|null: false|

### Association
- belongs_to :management
- Has_many :logs_menus
- Has_many :menus, thorough: :logs_menus

## logs_menusテーブル
|Column|Type|Options|
|------|----|-------|
|log|references|null: false, foreign_key: true|
|menu|references|null: false, foreign_key: true|
### Association
- belongs_to :log
- bekongs_to :menu

## menusテーブル
|Colmun|Type|Option|
|-------|----|------|
|menu|string|null: false|
|mass|integer|null: false|
### Association
- Has_many :logs_menus
- Has_many :logs, through: :logs_menus
- Has_many :menus_foods
- Has_many :foods, through: :menus_foods

## menus_foodsテーブル
|Column|Type|Options|
|------|----|-------|
|menu|references|null: false, foreign_key: true|
|food|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- bekongs_to :management

## foodsテーブル
|Colmun|Type|Option|
|-------|----|------|
|food|string|null: false|
|protain|double|null: false|
|fat|double|null: false|
|carbohydrate|double|null: false|
### Associtaion
- Has_many :menus_foods
- Has_many :menus, through: :menus_foods

