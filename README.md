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
- Has_many :users_managements
- Has_many :manegements, thorugh: :users_manegements

## managementsテーブル
|Colmun|Type|Option|
|-------|----|------|
|created_at|date|null: flase|
|body_mass_index|double||
|body_fat_parcentage|double||
|total_protain|integer||
|total_fat|integer||
|total_carbohydrate|integer||
### Association
- Has_many :users_managements
- Has_many :users, thorough: :users_manegements
- Has_many :manegements_logs
- Has_many :logs, thorough: :manegements_logs

## logsテーブル
|Colmun|Type|Option|
|-------|----|------|
|created_at|date|null: false|
|menu|string|null: false|
|protain|integer||
|fat|intenger||
|carbohydrate|integer||
### Asosociation
- Has_many :manegements_logs
- Has_many :manegements, thorough: :manegements_logs
- Has_many :logs_menus
- Has_many :menus, thorough: :logs_menus

## menusテーブル
|Colmun|Type|Option|
|-------|----|------|
|food



