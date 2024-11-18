# 概要
このアプリは、ユーザーが商品を出品し、購入することができるプラットフォームです。本アプリケーションはRuby on Railsを使用して構築されています。

## テーブル設計
以下は本アプリケーションのテーブル設計です。

### usersテーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_kana          | string | null: false |
| first_kana         | string | null: false |
| nickname           | string | null: false |
| birthday           | date   | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |

#### Association
- has_many :items
- has_many :orders

### itemsテーブル
| Column                 | Type       | Options           |
| ---------------------- | ---------- | ----------------- |
| name                   | string     | null: false       |
| description            | text       | null: false       |
| category_id            | integer    | null: false       |
| condition_id           | integer    | null: false       |
| price                  | integer    | null: false       |
| shipping_cost_id       | integer    | null: false       |
| prefecture_id          | integer    | null: false       |
| shipping_duration_id   | integer    | null: false       |
| user                   | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- has_one :order
- belongs_to :category (ActiveHash)
- belongs_to :condition (ActiveHash)
- belongs_to :shipping_cost (ActiveHash)
- belongs_to :prefecture (ActiveHash)
- belongs_to :shipping_duration (ActiveHash)

### ordersテーブル
| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :address

### addressesテーブル
| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| postcode      | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| block         | string     | null: false       |
| building      | string     | null: false       |
| phone         | string     | null: false       |
| order         | references | null: false, foreign_key: true |

#### Association
- belongs_to :order
- belongs_to :prefecture (ActiveHash)
