# アプリケーション名

repeatstudy 

# アプリケーション概要

学習した内容を発信することで、学んだことの理解を深めるのと同時に目標に向かって励まし合うことができる。

# URL

https://repeatstudy01.onrender.com

# Basic認証

ID      admin<br>
Pass    1673

# 利用方法

## 投稿
・トップページのヘッダーからユーザー新規登録を行う<br>
・New Studyボタンから画像、ツイート、タグを入力し投稿する<br>

## 他者を応援する
・一覧ページから投稿をクリックして、投稿の詳細を確認する
・応援したい投稿があればいいねボタンを押す
・応援したいユーザーがいればフォローをする

# アプリケーションを作成した背景

学習をより効率よく行いたいという自分の目的があり、学習した内容を追うとぷっとできる場所があれば学習の定着が早くなると考えた。学習を効率よく行えるようにアウトプットの場を設けてさらにモチベーションアップに繋げられるようにいいねやユーザー同士でフォローを行えるようにアプリケーションを開発した。

# 洗い出した要件

https://docs.google.com/spreadsheets/d/1uqFOBUPBGWN6h_41mczFOQcgD5wb-8Diiefg-85Mksc/edit#gid=982722306

# 実装予定の機能

現在、画像を複数枚投稿できるように機能の実装予定。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/f36d9da5a447b816f0f0cae94130495a.png)](https://gyazo.com/f36d9da5a447b816f0f0cae94130495a)

# 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/0d571d48e8ff746621d604a7591c933a.png)](https://gyazo.com/0d571d48e8ff746621d604a7591c933a)

# 開発環境

フロントエンド<br>
HTML/CSS、javascript<br>
<br>
サーバーサイド<br>
Ruby<br>
<br>
フレームワーク<br>
Ruby on Rails<br>
<br>
データベース<br>
PostgreSQL<br>
<br>
画像の保存先<br>
Amazon S3

# 工夫したポイント
フォロー、フォロワー機能の実装や、いいね機能を非同期通信で実装し、ユーザーの使いやすさを意識しながら実装した。カリキュラム外の知識が必要となる実装を行い実際の業務を意識して自分で調べて実装するという自走力も磨けた。

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