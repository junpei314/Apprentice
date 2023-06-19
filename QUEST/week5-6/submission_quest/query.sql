CREATE DATABASE internet_tv;

USE internet_tv;

CREATE TABLE channels(
  id smallint AUTO_INCREMENT, 
  name varchar(20) NOT NULL, 
  PRIMARY KEY(id), 
  UNIQUE KEY(name)
);

CREATE TABLE genres(
  id tinyint AUTO_INCREMENT, 
  name varchar(20) NOT NULL, 
  PRIMARY KEY(id), 
  UNIQUE KEY(name)
);

CREATE TABLE programs(
  id int AUTO_INCREMENT, 
  title varchar(100) NOT NULL,
  description text NOT NULL,
  genre_id tinyint NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(genre_id) REFERENCES genres(id),
  UNIQUE KEY(title)
);

CREATE TABLE episodes(
  id int AUTO_INCREMENT, 
  title varchar(100) NOT NULL,
  season_number tinyint DEFAULT 0,
  episode_number smallint DEFAULT 0,
  description text NOT NULL,
  video_time_length smallint NOT NULL,
  release_date date NOT NULL,
  program_id int,
  PRIMARY KEY(id),
  FOREIGN KEY(program_id) REFERENCES programs(id)
);

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


DESC カラム名;

mysqlimport -u osano -p --fields-terminated-by=',' --lines-terminated-by='\r\n' --local internet_tv2 channels.csv genres.csv programs.csv episodes.csv broadcasts.csv


作成したテーブル同士を結合

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


delimiter //
CREATE PROCEDURE insert_view_count()
BEGIN
    SET @limit = 100;
    SET @pos = 0;
    WHILE @limit > @pos DO
        UPDATE views
         SET view_count = FLOOR(100000 + RAND() * 1000000);
        SET @pos = @pos + 1;
    END WHILE;
END
//
delimiter ;

call insert_view_count();

以下のデータを抽出するクエリを書いてください。

よく見られているエピソードを知りたいです。
エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください

SELECT e.title, v.view_count
  FROM views AS v
 INNER JOIN episodes AS e 
    ON v.episode_id = e.id
 ORDER BY v.view_count DESC
 LIMIT 3
;

よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。
エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、
エピソードタイトル、視聴数を取得してください

SELECT p.title AS program_title, e.season_number, e.episode_number, e.title AS episode_title, v.view_count
  FROM views AS v
 INNER JOIN programs AS p
    ON v.program_id = p.id
 INNER JOIN episodes AS e
    ON v.episode_id = e.id
 ORDER BY v.view_count DESC
 LIMIT 3
;

本日の番組表を表示するために、本日、どのチャンネルの、
何時から、何の番組が放送されるのかを知りたいです。
本日放送される全ての番組に対して、チャンネル名、
放送開始時刻(日付+時間)、放送終了時刻、シーズン数、
エピソード数、エピソードタイトル、エピソード詳細を取得してください。
なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします

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


ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、
本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。
ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、
エピソードタイトル、エピソード詳細を本日から一週間分取得してください

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


(advanced) 直近一週間で最も見られた番組が知りたいです。
直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、
番組タイトル、視聴数を取得してください

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

(advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。
番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。
ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、
エピソード平均視聴数を取得してください。

・番組ごとにエピソードの平均視聴数を出す
・ジャンルごとに視聴数トップの番組を出す
・ジャンル名、番組タイトル、エピソード平均視聴数を出す

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


(SELECT avg_views.genre_id, MAX(avg_views.avg_view_count)
  FROM (SELECT p.genre_id, ROUND(AVG(v.view_count)) AS avg_view_count
        FROM views AS v
        INNER JOIN programs AS p
        ON v.program_id = p.id
        GROUP BY v.program_id, p.genre_id) AS avg_views
  GROUP BY avg_views.genre_id
  ORDER BY avg_views.genre_id)
;

SELECT p.title, ROUND(SUM(v.view_count))
  FROM views AS v
 INNER JOIN (SELECT p.id, p.title, g.id AS genre_id, g.name
            FROM programs AS p
            INNER JOIN genres AS g
            ON p.genre_id = g.id) AS p
    ON v.program_id = p.id
 GROUP BY v.program_id, p.title
;

(SELECT p.id, p.title, g.id, g.name
  FROM programs AS p
 INNER JOIN genres AS g
    ON p.genre_id = g.id)
;

select v.broadcast_id, b.program_id, v.episode_id, v.view_count
  from views as v
 inner join broadcasts as b
    on v.broadcast_id = b.id
 order by v.broadcast_id
;











LOAD DATA LOCAL INFILE 'prefectures.csv'
INTO TABLE prefectures
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
(id, name);