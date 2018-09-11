# ファイナンシャル・プランナー予約システム
## システム概要
ユーザーが FP との相談を予約できるシステム

※Railsの勉強課題用

## Ruby version

`2.3.1`

※Windows10 WSL での開発の都合上sudo使わないといけないので今回は暫定的にrootのruby2.3.1を使用

## テーブル定義

#### リレーション
* "Users" has many "Reservations"
* "Fps" has many "Reservations"
* "Reservations" belongs to "User"
* "Reservations" belongs to "Fp"
* "Fp" has many "Fp_reservable_times"
* "Fp_reservable_times" belongs to "Fp"

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
|fp_id|integer|T|F|T|
|user_id|integer|T|F|T|
|reserved_on|datetime|T|F|T|
|created_at|datetime|T|F|F|
|updated_at|datetime|T|F|F|

#### Fp_reservable_times

|カラム名|属性|NN|UQ|Index|
|:--:|:--:|:--:|:--:|:--:|
|id|integer|T|T|T|
|fp_id|integer|T|F|T|
|reservable_on|datetime|T|F|T|
|created_at|datetime|T|F|F|
|updated_at|datetime|T|F|F|