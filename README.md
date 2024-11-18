# 概要
このアプリは、ユーザーが商品を出品し、購入することができるプラットフォームです。本アプリケーションはRuby on Railsを使用して構築されています。

## テーブル設計
以下は本アプリケーションのテーブル設計です。

### usersテーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
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
| category               | string     | null: false       |
| condition              | string     | null: false       |
| price                  | integer    | null: false       |
| shipping_fee           | string     | null: false       |
| shipping_method        | string     | null: false       |
| shipping_from          | string     | null: false       |
| shipping_duration      | integer    | null: false       |
| user                   | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- has_one :order

### ordersテーブル
| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |
| address        | references | null: false, foreign_key: true |
| payment_status | string     | null: false       |
| shipment_status| string     | null: false       |
| total_price    | integer    | null: false       |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :address

### addressesテーブル
| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| postcode      | string     | null: false       |
| prefecture    | string     | null: false       |
| city          | string     | null: false       |
| line          | string     | null: false       |
| phone         | string     | null: false       |
| order         | references | null: false, foreign_key: true |

#### Association
- belongs_to :order
