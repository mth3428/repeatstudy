# テーブル設計


## users テーブル

| Columu             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| introduction       | text    | null: false              |

### Association

- has_many :comments
- has_many :posts

## posts テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| tweet              | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_many   :tags, through: :post_tags

## tags テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | string     | null: false                    |

### Association

- has_many  :posts, through: :post_tags


## post_tags テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post               | references | null: false, foreign_key: true |
| tag                | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag

## comments テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |
| message            | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :post