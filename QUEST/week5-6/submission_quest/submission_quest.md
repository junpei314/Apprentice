## ステップ1

テーブル:channels
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|id|smallint||PRIMARY||YES|
|name|varchar(20)|||||
- ユニークキー制約
    - nameに対して設定

テーブル:genres
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|id|tinyint||PRIMARY||YES|
|name|varchar(20)|||||
- ユニークキー制約
    - nameに対して設定


テーブル:programs
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|id|int||PRIMARY||YES|
|title|varchar(100)|||||
|description|text|||||
|genre_id|tinyint|||||
- 外部キー制約
    - genre_idに対してgenresテーブルのidから設定
- ユニークキー制約
    - titleに対して設定

テーブル:episodes
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|id|int||PRIMARY||YES|
|title|varchar(100)|||||
|season_number|tinyint|||0||
|episode_number|smallint|||0||
|description|text|||||
|video_time_length|smallint|||||
|release_date|date|||||
|program_id|int|||||
- 外部キー制約
    - program_idに対してprogramsテーブルのidから設定

テーブル:broadcasts
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|id|int||PRIMARY||YES|
|program_id|int|||||
|air_date|date|||||
|start_time|time|||||
|end_time|time|||||
|channel_id|smallint|||||
- 外部キー制約
    - program_idに対してprogramsテーブルのidから設定
    - channel_idに対してchannelsテーブルのidから設定 


テーブル:views
|COLUMN NAME|DATA TYPE|NULL|KEY|DEFAULT|AUTO INCREMENT|
|-----------|---------|----|---|-------|--------------|
|broadcast_id|int||PRIMARY|||
|program_id|int||PRIMARY|||
|episode_id|int||PRIMARY|||
|view_count|bigint|||0||
- 外部キー制約
    - broadcast_idに対してbroadcastsテーブルのidから設定
    - program_idに対してprogramsテーブルのidから設定
    - episode_idに対してepisodesテーブルのidから設定


## ステップ2
### データベースを構築
MySQLにログインし、下記のクエリを実行してデータベースを作成する
```title:データベースを作成
CREATE DATABASE internet_tv;
```
作成したデータベースを選択する
```title:データベースを選択
USE internet_tv;
```

### ステップ1で設計したテーブルを構築
以下のクエリを実行し、設計したテーブルを作成する
```title:channelsテーブルの作成
CREATE TABLE channels(
  id smallint AUTO_INCREMENT, 
  name varchar(20) NOT NULL, 
  PRIMARY KEY(id), 
  UNIQUE KEY(name)
);
```
```title:genresテーブルの作成
CREATE TABLE genres(
  id tinyint AUTO_INCREMENT, 
  name varchar(20) NOT NULL, 
  PRIMARY KEY(id), 
  UNIQUE KEY(name)
);
```

```title:programsテーブルの作成
CREATE TABLE programs(
  id int AUTO_INCREMENT, 
  title varchar(100) NOT NULL,
  description text NOT NULL,
  genre_id tinyint NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(genre_id) REFERENCES genres(id),
  UNIQUE KEY(title)
);
```

```title:episodesテーブルの作成
CREATE TABLE episodes(
  id int AUTO_INCREMENT, 
  title varchar(100) NOT NULL,
  season_number tinyint NOT NULL DEFAULT 0,
  episode_number smallint NOT NULL DEFAULT 0,
  description text NOT NULL,
  video_time_length smallint NOT NULL,
  release_date date NOT NULL,
  program_id int,
  PRIMARY KEY(id),
  FOREIGN KEY(program_id) REFERENCES programs(id)
);
```

```title:broadcastsテーブルの作成
CREATE TABLE broadcasts(
  id int AUTO_INCREMENT, 
  program_id int NOT NULL,
  air_date date NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL,
  channel_id smallint NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(program_id) REFERENCES programs(id),
  FOREIGN KEY(channel_id) REFERENCES channels(id)
);
```
```title:viewsテーブルの作成
CREATE TABLE views(
  broadcast_id int,
  program_id int,
  episode_id int,
  view_count bigint NOT NULL DEFAULT 0,
  PRIMARY KEY(broadcast_id, program_id, episode_id),
  FOREIGN KEY(broadcast_id) REFERENCES broadcasts(id),
  FOREIGN KEY(program_id) REFERENCES programs(id),
  FOREIGN KEY(episode_id) REFERENCES episodes(id)
);
```
以上でテーブルの作成は完了
下記クエリを実行し、作成したテーブルに間違いがないか確認する
```title:仕様通りに作成されているか確認
DESC 'テーブル名'　;
```


### サンプルデータを入力
- 下記のサンプルデータをtsvファイルで用意する
    - channels.csv
    - genres.csv
    - episodes.csv
    - programs.csv
    - broadcasts.csv

### テキストファイルを直接テーブルにロードする

以下のコードで設定ファイルのステータスを確認する
```sql
SELECT @@local_infile;
```
以下の様に出力された場合はファイルのロードがオフになっている
```title:出力結果
+----------------+
| @@local_infile |
+----------------+
|              0 |
+----------------+
1 row in set (0.00 sec)
```
以下のコードを実行しファイルをロードできるようにする
```sql
SET GLOBAL local_infile=on;
```
以下の様に出力されればOK
```title:出力結果
+----------------+
| @@local_infile |
+----------------+
|              1 |
+----------------+
1 row in set (0.00 sec)
```

#### mysqlimportを使う
quitでMySQLからログアウトする
以下のコードをコマンドプロンプトで実行し、用意したすべてのサンプルデータをテーブルに格納する
またカレントディレクトリにcsvファイルを置いておくと楽
```shell
mysqlimport -u ユーザー名 -p --fields-terminated-by=',' --lines-terminated-by='\r\n' --local internet_tv channels.csv genres.csv programs.csv episodes.csv broadcasts.csv

```
##### 注意点
- mysqlimportは指定したファイル名からテーブル名を推測するため、ファイル名はテーブル名と同じものにする
    - channelsテーブルにテキストファイル内のデータを格納する場合は、あらかじめchannels.tsvにしておく
- デフォルトではタブで列を、改行で行を区切るため、特にオプションで指定しない場合はtsvファイルにする
    - csvのようにカンマで列を区切る場合は`--fields-terminated-by=','`を追記する

#### broadcastsテーブルとepisodesテーブルを結合し、viewsテーブルに挿入する
MySQLにログインする
`USE internet_tv`でデータベースを選択する
以下のクエリでviewsテーブルにデータを挿入する
```
INSERT INTO views (broadcast_id, program_id, episode_id)
SELECT *
  FROM (
SELECT b.id AS broadcast_id, e.program_id, e.id AS episode_id
  FROM broadcasts AS b
 INNER JOIN episodes AS e
    ON b.program_id = e.program_id
 ORDER BY b.id
) AS views
;
```

#### 視聴数をランダムに作成し、viewsテーブルのview_countに挿入するためのストアドプロシージャを作成する
```
delimiter //
CREATE PROCEDURE insert_view_count()
BEGIN
    SET @limit = 100;
    SET @count = 0;
    WHILE @limit > @count DO
        UPDATE views
         SET view_count = FLOOR(100000 + RAND() * 1000000);
        SET @count = @count + 1;
    END WHILE;
END
//
delimiter ;
```
#### ストアドプロシージャを実行する
```
call insert_view_count();
```

## ステップ3
- よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
```
SELECT e.title, v.view_count
  FROM views AS v
 INNER JOIN episodes AS e 
    ON v.episode_id = e.id
 ORDER BY v.view_count DESC
 LIMIT 3
;
```
- よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
```
SELECT p.title AS program_title, e.season_number, e.episode_number, e.title AS episode_title, v.view_count
  FROM views AS v
 INNER JOIN programs AS p
    ON v.program_id = p.id
 INNER JOIN episodes AS e
    ON v.episode_id = e.id
 ORDER BY v.view_count DESC
 LIMIT 3
;
```
- 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
```
SELECT bc.name, bc.air_date, bc.start_time, bc.end_time, p.title AS program_title, e.season_number, e.episode_number, e.title AS episode_title, e.description
  FROM views AS v
 INNER JOIN (SELECT b.id, b.air_date, b.start_time, b.end_time, c.name
  FROM broadcasts AS b
 INNER JOIN channels AS c
    ON b.channel_id = c.id) AS bc
    ON v.broadcast_id = bc.id
 INNER JOIN programs AS p
    ON v.program_id = p.id
 INNER JOIN episodes AS e
    ON v.episode_id = e.id
WHERE bc.air_date = CURRENT_DATE()
;
```
- ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください

```
SELECT bc.name, bc.air_date, bc.start_time, bc.end_time, e.season_number, e.episode_number, e.title AS episode_title, e.description
  FROM views AS v
 INNER JOIN (SELECT b.id, b.air_date, b.start_time, b.end_time, c.name
  FROM broadcasts AS b
 INNER JOIN channels AS c
    ON b.channel_id = c.id) AS bc
    ON v.broadcast_id = bc.id
 INNER JOIN programs AS p
    ON v.program_id = p.id
 INNER JOIN episodes AS e
    ON v.episode_id = e.id
 WHERE bc.air_date <= (CURRENT_DATE() + INTERVAL 1 WEEK)
   AND bc.air_date >= CURRENT_DATE()
   AND bc.name IN ('ドラマ1', 'ドラマ2')
;
```
- (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください

```
SELECT bp.title, SUM(v.view_count)
  FROM views AS v
 INNER JOIN episodes AS e
    ON v.episode_id = e.id
 INNER JOIN (SELECT b.id AS broadcast_id, p.id AS program_id, p.title, b.air_date
            FROM broadcasts AS b
            INNER JOIN programs AS p
            ON b.program_id = p.id
            WHERE b.air_date >= (CURRENT_DATE() - INTERVAL 1 WEEK)
            AND b.air_date <= CURRENT_DATE()
            ) AS bp
    ON v.broadcast_id = bp.broadcast_id
 GROUP BY bp.broadcast_id, bp.title
 ORDER BY SUM(v.view_count) DESC
 LIMIT 2
;
```
- (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

```
SELECT programs_genres.genre_name, programs_genres.title, genres_max_views.max_views
  FROM (SELECT p.title, p.genre_id, p.genre_name, ROUND(AVG(v.view_count)) AS avg_view_count
          FROM views AS v
         INNER JOIN (SELECT p.id, p.title, g.id AS genre_id, g.name AS genre_name
                       FROM programs AS p
                      INNER JOIN genres AS g
                         ON p.genre_id = g.id) AS p
            ON v.program_id = p.id
         GROUP BY v.program_id, p.title, p.genre_id, p.genre_name) AS programs_genres
 INNER JOIN (SELECT avg_views.genre_id, MAX(avg_views.avg_view_count) AS max_views
               FROM (SELECT p.genre_id, ROUND(AVG(v.view_count)) AS avg_view_count
                     FROM views AS v
                     INNER JOIN programs AS p
                     ON v.program_id = p.id
                     GROUP BY v.program_id, p.genre_id) AS avg_views
              GROUP BY avg_views.genre_id
              ORDER BY avg_views.genre_id) AS genres_max_views
    ON programs_genres.genre_id = genres_max_views.genre_id
   AND programs_genres.avg_view_count = genres_max_views.max_views
;
```
