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
- has_many :favorites

## posts テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| tweet              | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_many   :tags, through: :post_tags
- has_many   :favorite
- belongs_to :user

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


## favorites テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :user

## relationships テーブル

| Columu             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| following_id       | integer    | null: false                    |
| follower_id        | integer    | null: false                    |

### Association

- belongs_to :following
- belongs_to :follower

## followings テーブル

usersテーブルと同じ内容

### Association

- has_many :relationships


## follower テーブル

usersテーブルと同じ内容

### Association

- has_many :relationships