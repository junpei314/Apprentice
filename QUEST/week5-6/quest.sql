create table test (
  id int not null auto_increment,
  name char(30) not null,
  age int,
  primary key(id)
);

SELECT
  a.dept_no,
  b.emp_no,
  c.dept_name,
  b.first_name,
  b.last_name
FROM
  dept_manager a
INNER JOIN
  employees b
ON
  a.employee_no=b.emp_no

INNER JOIN
  departments c
ON
  a.dept_no=c.dept_no

WHERE
  a.to_date='9999-01-01';


SELECT
  a.emp_no,
  a.first_name,
  a.last_name,
  MIN(b.from_date),
  MAX(b.to_date),
  SUM(b.salary)
FROM
  employees a
INNER JOIN
  salaries b
ON
  a.emp_no=b.emp_no
WHERE
  a.emp_no >= 10001 and a.emp_no <= 10010
GROUP BY
  a.emp_no;


SELECT emp_no, salary
  FROM salaries
 WHERE emp_no >= 10001 
   AND emp_no <= 10010
   AND salary > (
       SELECT AVG(salary)
       FROM salaries
       )
;

SELECT DISTINCT emp_no, salary
  FROM salaries
 WHERE salary > (
       SELECT AVG(salary) * 2
         FROM salaries
       )
;

SELECT emp_no, MAX(salary)
  FROM salaries
 WHERE emp_no >= 10001
   AND emp_no <= 10010
   AND salary > (
       SELECT AVG(salary)
         FROM salaries
   )
 GROUP BY emp_no
;


従業員のうち、性別ごとに最高年齢の従業員の性別、従業員番号、誕生日を、相関サブクエリを使用して取得してください。

SELECT gender, emp_no, birth_date
  FROM (
       SELECT *
       FROM employees
       WHERE emp_no >= 10100
       AND emp_no <= 10200
       ORDER BY emp_no
       LIMIT 10000
       ) AS e1
 WHERE birth_date = (
       SELECT MIN(birth_date)
         FROM (
              SELECT *
              FROM employees
              WHERE emp_no >= 10100
              AND emp_no <= 10200
              ORDER BY emp_no
              LIMIT 10000
              ) AS e2
        WHERE e1.gender = e2.gender
       )
;

SELECT gender, emp_no, birth_date
  FROM employees AS e1
 WHERE birth_date = (
       SELECT MIN(birth_date)
         FROM employees AS e2
        WHERE e1.gender = e2.gender
       )
;

従業員番号10100から10200の従業員の中で、それぞれの性別で最も
若い年齢の人の性別、誕生日、従業員番号、ファーストネーム、ラストネームを取得してください。



SELECT emp_no, to_date
  FROM  salaries
 WHERE emp_no >= 10100
   AND emp_no <= 10200
;

SELECT emp_no, t1, CASE WHEN t1 = '9999-01-01' THEN 'unemployed'
       ELSE 'employed'
   END AS 'employed/unemployed'
FROM (   
   SELECT emp_no, MAX(to_date) AS t1
  FROM  salaries
 WHERE emp_no >= 10100
   AND emp_no <= 10200
 GROUP BY emp_no
) AS staff
;

SELECT emp_no, birth_date, 
  CASE 
       WHEN birth_date LIKE '196_-__-__' THEN '60s'
       WHEN birth_date LIKE '195_-__-__' THEN '50s'
       ELSE 'test'
   END AS 'period'
  FROM employees
 WHERE emp_no >= 10001
   AND emp_no <= 10050
;


SELECT e1.period, MAX(s.salary)
FROM (
SELECT emp_no, birth_date, 
  CASE 
       WHEN birth_date LIKE '196_-__-__' THEN '60s'
       WHEN birth_date LIKE '195_-__-__' THEN '50s'
       ELSE 'test'
   END AS 'period'
  FROM employees
 WHERE emp_no >= 10001
   AND emp_no <= 10050
) AS e1 INNER JOIN salaries AS s ON e1.emp_no = s.emp_no
 GROUP BY e1.period
;

EXPLAIN SELECT * FROM salaries WHERE salary = 70575;

EXPLAIN ANALYZE SELECT * FROM salaries WHERE salary = 70575;

EXPLAIN SELECT * FROM salaries WHERE emp_no = 10100;
EXPLAIN ANALYZE SELECT * FROM salaries WHERE emp_no = 10100;

SELECT *
  FROM employees
 WHERE emp_no IN(10011, 10021, 10031);

employees データベースの employees テーブルに対して、誕生日が1961年8月3日のレコードを取得してください。その際に、EXPLAIN ANALYZE ステートメントを利用することで、実行時間を計測してください。
EXPLAIN ANALYZE
SELECT * 
  FROM employees
 WHERE birth_date = '1961-08-03'
;

actual time=0.067..105.205 インデックス追加前
actual time=29.122..29.163 インデックス追加後

employees データベースの employees テーブルの birth_date カラムにインデックスを作成してください。
ALTER TABLE employees ADD INDEX birth_date_index(birth_date);

insert into items values(001, '石鹸', 'C1'), (002, 'タオル', 'C1'), (003, 'ハブラシ', 'C1'), (004, 'コップ', 'C1'), (005, '箸', 'C2'), (006, 'スプーン', 'C2'), (007, '雑誌', 'C3'), (008, '爪切り', 'C4');
insert into item_category values('C1', '水洗用品'), ('C2', '食器'), ('C3', '書籍'), ('C4', '日用雑貨');
SELECT c.category_name, count(*)
  FROM item_category AS c
 INNER JOIN items AS i
    ON c.item_category_code = i.item_category_code
 GROUP BY(c.category_name)
;

SELECT o.name, s.name, i.name
  FROM shop_items
 INNER JOIN branch_office AS o 
    ON shop_items.branch_code = o.branch_code
 INNER JOIN branch_shop AS s
    ON shop_items.shop_code = s.shop_code and shop_items.branch_code = s.branch_code
 INNER JOIN items AS i
    ON shop_items.item_code = i.item_code
;

SELECT s.name, MAX(item_count)
FROM (
      SELECT s.name, count(*) AS item_count
        FROM shop_items
      INNER JOIN branch_office AS o 
          ON shop_items.branch_code = o.branch_code
      INNER JOIN branch_shop AS s
          ON shop_items.shop_code = s.shop_code and shop_items.branch_code = s.branch_code
      INNER JOIN items AS i
          ON shop_items.item_code = i.item_code
      GROUP BY(s.name)
)
;

SELECT s.name, count(*)
  FROM shop_items
 INNER JOIN branch_office AS o 
    ON shop_items.branch_code = o.branch_code
 INNER JOIN branch_shop AS s
    ON shop_items.shop_code = s.shop_code and shop_items.branch_code = s.branch_code
 INNER JOIN items AS i
    ON shop_items.item_code = i.item_code
 GROUP BY(s.name)
 ORDER BY count(*) DESC
 LIMIT 1
;
