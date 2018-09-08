# ファイナンシャル・プランナー予約システム
## システム概要
ユーザーが FP との相談を予約できるシステム

※Railsの勉強課題用

## Ruby version

`2.5.1`

## テーブル定義

#### リレーション
* "Users" has many "Reservations"
* "Fps" has many "Reservations"
* "Reservations" belongs to "User"
* "Reservations" belongs to "Fp"

#### Users
* NN -> Not Null
* UQ -> Unique

|カラム名|属性|NN|UQ|Index|
|:--:|:--:|:--:|:--:|:--:|
|id|integer|T|T|T|
|name|string|T|F|F|
|email|string|T|T|T|
|password_digest|string|T|F|F|
|created_at|datetime|T|F|F|
|updated_at|datetime|T|F|F|

#### Fps

|カラム名|属性|NN|UQ|Index|
|:--:|:--:|:--:|:--:|:--:|
|id|integer|T|T|T|
|name|string|T|F|F|
|email|string|T|T|T|
|password_digest|string|T|F|F|
|created_at|datetime|T|F|F|
|updated_at|datetime|T|F|F|

#### Reservations

|カラム名|属性|NN|UQ|Index|
|:--:|:--:|:--:|:--:|:--:|
|id|integer|T|T|T|
|user_id|integer|T|F|T|
|fp_id|integer|T|F|T|
|reserved_at|datetime|T|F|F|
|created_at|datetime|T|F|F|
|updated_at|datetime|T|F|F|
