# ![MySQL](https://img.shields.io/badge/-MySQL-190004?style=for-the-badge&logo=mysql&logoColor=00618a)

Источник <https://stepik.org/course/133728/syllabus>

## SQL queries

---

>### Комментарии

* `/* (начало)` и `*/ (конец)` многострочный
* `--` однострочный

---

>### Выбор данных из таблиц

```SQL
/* выбрать все столбцы из таблицы */
SELECT *
  FROM table_1; 

/* выбрать конкретные столбцы из таблицы */
SELECT column_1,
       column_2,
       column_3
  FROM table_1; 

/* WHERE дополнительное условия для выбора данных */
SELECT *
  FROM table_1
 WHERE new_year > 2000;

/* DISTINCT выбрать уникальные строки из таблицы */
SELECT DISTINCT column_1
  FROM table_1;

/* LIMIT вернет первые 3 строки из таблицы */
SELECT * 
  FROM table_1 
 LIMIT 3;

/* OFFSET пропуст первые 3 строки из таблицы */
SELECT *
  FROM table_1
 LIMIT 3
 OFFSET 3;
```

---

>### Сортировка данных

```SQL
/* ORDER BY позволяет сортировать данные */
SELECT column1,
       column2
  FROM table_name
 ORDER BY column1 ASC,  -- сортировать по возрастанию
          column2 DESC; -- сортировать по убыванию
```

---

>### Фильтрация данных

```SQL
/* WHERE */
SELECT *
  FROM table_name
 WHERE column_1 > 2000
   AND column_2  = 'Action';

/* WHERE и логические операторы AND, OR и NOT */
SELECT *
  FROM table_name
 WHERE (column_1  = 'Biography' 
    OR column_1 = 'Drama') -- () cначала будет выполняться условие внутри скобок, затем AND
   AND column_2 > 7
   AND column_3 > 1990;

SELECT *
  FROM table_name
 WHERE column_1 NOT IN ( 2000, 2003 );

/* WHERE может использоваться с различными операторами 
   Равенство: =, <> (не равно)
   Сравнение: >, <, >=, <=
   Логические операторы: AND, OR, NOT
   Операторы: IN и NOT IN
   Операторы: LIKE, NOT LIKE
   Операторы: BETWEEN..AND
   Операторы: IS NULL, IS NOT NULL
*/

/*
  Арифметические операторы могут быть использованы в комбинации с оператором SELECT при фильтрации данных в таблице
  Сложение: +
  Вычитание: -
  Умножение: *
  Деление: /
  Деление по модулю: %
  Обратите внимание, что в запросах мы использовали псевдонимы для вычисляемых полей. Это позволяет получить новый результат с сохранением исходной таблицы, в то время как сам запрос не изменяет данные в исходной таблице.
*/
SELECT column_1,
       column_2,
       column_3 + 100 AS new_name_column_3 -- добавление 100 к каждому полю в колонке column_3 
  FROM table_name
 WHERE column_3 > 1800;

/* Деление по модулю: % */

 WHERE movies.id % 3 = 0  -- выбрать только каждое 3 значение 
 WHERE movies.id % 2 = 0  -- выбрать только каждое 2 значение 
```

---

>### Переменные

```SQL
/* 
  Названия переменных начинаются с символа @, после которого могут использоваться буквы латинского алфавита, цифры и знаки $, _.  
  Переменные не чувствительны к регистру.
*/

SET @year := 1994;           -- создания переменной

SELECT title
  FROM movies
 WHERE release_year = @year;

SET @start := 1994, 
    @end := 2000;            -- создание нескольких переменных через ,

SELECT title
  FROM movies
 WHERE release_year BETWEEN @start AND @end;

SET @search := 'The%';       -- значение переменной до конца неопределенно

SELECT title
  FROM movies
 WHERE title LIKE @search;

/* 
  После назначения вы можете использовать переменную в последующем операторе, где выражение разрешено, например, в  предложении WHERE, операторе INSERT или UPDATE. 
*/
 
SELECT @max_year := MAX(release_year) -- MAX максимальное значение в таблице 
  FROM movies;                        -- второй способ создания переменной в SELECT 

SELECT title
  FROM movies
 WHERE release_year = @max_year;
```

---

>### Alias (псевдоним) AS

```SQL
SELECT m.id,
       m.title AS movie_title
  FROM movies AS m;
```

---

>### Группировка GROUP BY

```SQL
/* 
  GROUP BY позволяет объединять данные по определенному полю или списку полей, чтобы вычислить значения, такие как сумма, среднее, максимум и минимум, в сочетании с MIN, MAX, SUM, AVG и COUNT, для выполнения вычислений над сгруппированными данными.
*/

SELECT genre,
       AVG(rating) AS avg_rating
  FROM movies
 GROUP BY genre; /* выделяет уникальные поля из колонки и высчитывается среднее значения для этих полей из колонки rating  */

/* 
  Чтобы округлить результаты, вы можете использовать функцию ROUND.
  Функция ROUND принимает два аргумента: значение, которое нужно округлить, и количество десятичных разрядов, до которого нужно округлить. 
*/

SELECT genre,
       ROUND(AVG(rating), 1) AS avg_rating
  FROM movies
 GROUP BY genre;

SELECT genre,
       COUNT(id) AS count    -- подсчет полей в колонке
  FROM movies
 GROUP BY genre;

/* 
  HAVING используется как условие
  Основное отличие WHERE от HAVING заключается в том, что WHERE сначала выбирает строки, а затем группирует их и вычисляет агрегатные функции (таким образом, она отбирает строки для вычисления агрегатов (агрегатными функциями)), тогда как HAVING отбирает строки групп после группировки и вычисления агрегатных функций. 
*/

SELECT genre,
       COUNT(id) AS count
  FROM movies
 GROUP BY genre
HAVING COUNT(id) > 1;  /* покажет сколько значений в колонке, при условии, что этих  значений больше чем 1 | используется вместо WHERE для фильтрации групп, иначе ошибка */

SELECT release_year,
       genre,
       COUNT(id) AS count
  FROM movies
 GROUP BY release_year,
          genre;           -- группировать по нескольким полям
```

---

>### Подзапросы

```SQL
SELECT *
  FROM movies
 WHERE rating > (SELECT AVG(rating) 
                   FROM movies);

SELECT *
  FROM movies
 WHERE release_year = (SELECT MIN(release_year)
                         FROM movies);

/* 
  Оператор ANY используется для сравнения значения какого-либо столбца в одной таблице с набором значений в другой таблице.
  Он возвращает true, если хотя бы одно значение совпадает с значением столбца в основной таблице
  ANY - аналог оператора IN, только перед оператором ANY можно использовать операторы =, <>, !=, >, >=, <, <= в отличие от IN
*/

SELECT *
  FROM movies
 WHERE title = ANY (SELECT title 
                      FROM top_rated_movies);  /* если в колонке title из таблицы movies 
есть совпадения с колонкой title из таблицы top_rated_movies, тогда мы получим ответ по совпадениям */

/* 
  Оператор ALL сравнивает каждое значение со всеми значениями из подзапроса. ALL - возвращает значение true, если все значения подчиненного запроса удовлетворяют условию. 
  Оператор ALL используется, когда вы хотите сравнить значение из основного запроса со всеми значениями из подзапроса.
*/

SELECT *
  FROM movies
 WHERE rating >= ALL (SELECT rating 
                        FROM top_rated_movies); /* если rating из таблицы movies больше или
равен значению rating из таблицы top_rated_movies тогда показать все найденные значения, если хотя бы одно не совпадает, тогда нет результата */

```

---

>### UNION и UNION ALL

```SQL
/*
  Каждый из операторов SELECT должен иметь в своем запросе одинаковое количество столбцов и типы данных, иначе произойдет ошибка.
*/
SELECT column1,
       column2,
       ...
  FROM table_name_1
UNION                 -- исключая дубликаты
SELECT column1,
       column2,
       ...
  FROM table_name_2

SELECT column1,
       column2,
       ...
  FROM table_name_1
UNION  ALL             -- включая дубликаты
SELECT column1,
       column2,
       ...
  FROM table_name_2
```

---

>### Представления CREATE VIEW

```SQL
/* 
  Представления — это виртуальные таблицы, которые содержат результаты запроса, как будто они являются обычными таблицами в базе данных. 
*/

CREATE VIEW high_rated_movies -- создание виртуальной таблицы
AS
SELECT title,
       rating
  FROM movies
 WHERE rating > 8;

SELECT *
  FROM high_rated_movies;     -- используем обычный SQL запрос для обращения к новой таблице
```

---

>### Агрегатные функции MIN, MAX, COUNT, AVG, SUM

```SQL
SELECT MIN(release_year)
  FROM movies;

SELECT MAX(release_year)
  FROM movies
 WHERE genre = 'Action';

SELECT COUNT(DISTINCT genre) 
  FROM movies;                -- подсчета уникальных значений в конкретном столбце

SELECT COUNT(*) 
  FROM movies 
 WHERE rating > 8;

SELECT genre, COUNT(*) 
  FROM movies 
 GROUP BY genre;

SELECT AVG(budget)
  FROM movies
 WHERE genre = 'Action';

SELECT genre,
       AVG(budget)
  FROM movies
 GROUP BY genre;

SELECT SUM(budget)
  FROM movies
 WHERE genre = 'Action'
   AND release_year IN ( 2008, 2010 );

SELECT genre,
       SUM(budget)
  FROM movies
 GROUP BY genre;
```

---

>### Функции для работы со строками

```SQL
/* Функция CONCAT предназначена для объединение строк. */

SELECT CONCAT(title, ' (', release_year, ')') AS movie
  FROM movies;

SELECT UPPER(CONCAT('#',id, ' ', title)) AS movie  -- ' ' пробел
  FROM movies;

/* 
  Функция CONCAT_WS в SQL предназначена для объединение строк, но в качестве первого параметра принимает разделитель, который будет соединять строки. 
*/

SELECT CONCAT_WS(' ', title, '(', release_year, ')') AS movie
  FROM movies;

/* Функция LENGTH возвращает количество символов в строке. */

SELECT title,
       LENGTH(title) AS title_length
  FROM movies;

/* Функция LTRIM предназначена для удаления начальных пробелов из строки. */

SELECT LTRIM(title) AS title
  FROM movies;

SELECT COUNT(*)
  FROM reviews
  WHERE LENGTH (comment) > 20 
    AND comment NOT lIKE 'The%';

/* Функция RTRIM предназначена для удаления конечных пробелов из строки. */

SELECT RTRIM(title) AS title
  FROM movies;

/* Функция TRIM предназначена для удаления пробелов начальных и конечных из строки. */

SELECT TRIM(title) AS title
  FROM movies;

/* 
  Функция LOCATE имеет такие аргументы find, search [, start] и предназначена для возвращения позиции первого вхождения подстроки find в строку search. Дополнительный параметр start позволяет установить позицию в строке search, с которой начинается поиск подстроки find. Если подстрока search не найдена, то возвращается 0. 
  Аргументы:
  find Подстрока для поиска в строке.
  search Строка для поиска.
  start Необязательный. Позиция в строке, с которой начнется поиск. Если опущено, то по умолчанию равно 1. Первая позиция в строке - 1
*/  

SELECT title,
       LOCATE('The', title) AS result
  FROM movies;                      --  вернет все строки и укажет в которых встречается 'The'

/* 
  Функция LEFT  предназначена для вырезания после начала строки определенное количество символов. 
*/

SELECT LEFT(title, 3) AS title
  FROM movies;                 -- вывод только первых 3 символов

/* 
  Функция RIGHT в SQL предназначена для вырезания перед концом строки определенное количество символов.
  Первый аргумент функции - строка, а второй - количество символов, которые надо вырезать перед концом строки. 
  */

SELECT RIGHT(title, 3) AS title
  FROM movies;                   -- вывод 3 последних символов 

/* Функция SUBSTRING предназначена для вырезания из строки подстроку. */ 

SELECT SUBSTRING(title, 3) AS title
  FROM movies;                       -- вырезать первые символы остальное отобразить

/* Функция REPLACE предназначена для замены в строке. */

SELECT REPLACE(title, 'The', 'THE') AS title
  FROM movies;

/* Функция LOWER предназначена для перевода строки в нижний регистр. */

SELECT LOWER(title) AS title
  FROM movies;

/* Функция UPPER предназначена для перевода строки в верхний регистр. */

SELECT UPPER(title) AS title
  FROM movies;

/* Функция REPEAT предназначена для повторения строки определенное количество раз. */ 

SELECT title,
       CONCAT(REPEAT('☆', rating)) AS stars -- объединяем строки и заменяем цифры на ☆ нужное количество раз
  FROM movies;

SELECT LOWER ( REPLACE( REPLACE( REPLACE( REPLACE(title, ' ', '-'), 
                                                          ',', ''),
                                                          '.', ''),
                                                          ':', '')) AS slug -- множественная замена в 1 строке
       
 FROM movies;

/* 
  Функция ELT предназначена для возврата строки с порядковым номером, указанным в списке аргументов.
  Первый аргумент функции указывает индекс строки, которую необходимо извлечь из списка аргументов. 
*/ 

SELECT title,
       ELT(rating,
           '☆', 
           '☆☆', 
           '☆☆☆', 
           '☆☆☆☆', 
           '☆☆☆☆☆', 
           '☆☆☆☆☆☆', 
           '☆☆☆☆☆☆☆', 
           '☆☆☆☆☆☆☆☆',
           '☆☆☆☆☆☆☆☆☆', 
           '☆☆☆☆☆☆☆☆☆☆') AS stars -- замена rating на ☆☆☆☆☆☆☆☆☆☆ если в строке есть число 10 и тд.
  FROM movies;

SELECT title,     
       ELT(rating / 2,         -- делим rating на 2
         '★☆☆☆☆',
         '★★☆☆☆',
         '★★★☆☆',
         '★★★★☆',
         '★★★★★') AS stars          
  FROM movies
 ORDER BY rating DESC;
```

---

>### Функции для работы с числами

```SQL
/* Функция ROUND предназначена для округления числа. */

SELECT genre,
       ROUND(AVG(rating), 2) AS rating
  FROM movies
 GROUP BY genre;

/* Функция ABS предназначена для возврата абсолютного значения числа. */


SELECT ABS(-123)   -- приведет число -123 в 123 

/* Функция CEILING предназначена для возврата наименьшее целое число, которое больше или равно текущему значению. */

SELECT genre,
       CEILING(AVG(rating)) AS rating   -- округление числа в большую сторону 
  FROM movies
 GROUP BY genre;

/* Функция FLOOR предназначена для возврата наибольшее целое число, которое меньше или равно текущему значению. */ 

SELECT genre,
       FLOOR(AVG(rating)) AS rating    -- округление числа в меньшую сторону
  FROM movies
 GROUP BY genre;

/* Функция RAND предназначена для генерации случайного числа с плавающей точкой в диапазоне от 0 до 1. */

SELECT title,
       rating,
       RAND() AS random
  FROM movies;
```

---

>### Функции для работы с датами и временем

```SQL
/* Функция CURRENT_TIMESTAMP предназначена для возврата текущей даты и времени в часовом поясе текущей сессии SQL */

SELECT title,
       rating,
       CURRENT_TIMESTAMP()
  FROM movies;

/* Функция CURRENT_TIME предназначена для возврата текущего времени в часовом поясе текущей сессии SQL */

SELECT title,
       rating,
       CURRENT_TIME()
  FROM movies;

/* Функция CURRENT_DATE предназначена для возврата текущей даты в часовом поясе текущей сессии SQL. */

SELECT title,
       rating,
       CURRENT_DATE()
  FROM movies;

/* Функция DATE предназначена для возврата даты. */

SELECT title,
       rating,
       DATE(release_date)  -- вернет даты из колонки release_date в новом формате yy.mm.dd без времени
  FROM movies;

select date('2023-01-31 10:37:22'),
       date('20230131103722'),
       date('2023/01/31 10.37.22'),
       date('2023*01*31*10*37*22')  -- вернёт 2023-01-31

/* 
  Функция DAY предназначена для возврата дня.
  Возвращается номер дня месяца той даты, которая передаётся в функцию. Если месяц в дате отсутствует или в функцию передаётся 0, то возвращается базовый день , т.е. 1 (1 января).
*/

SELECT title,
       rating,
       DAY(release_date)  -- вернет только день
  FROM movies;

/* Функция MONTH предназначена для возврата месяца. */

SELECT title,
       rating,
       MONTH(release_date)
  FROM movies;

/* Функция YEAR предназначена для возврата года. */

SELECT title,
       rating,
       YEAR(release_date)
  FROM movies;

/* Функция HOUR предназначена для возврата часов. */

SELECT title,
       rating,
       HOUR(release_date)
  FROM movies;

/* Функция MINUTE предназначена для возврата минут. */

SELECT title,
       rating,
       MINUTE(release_date)
  FROM movies;

/* Функция SECOND предназначена для возврата секунд. */

SELECT title,
       rating,
       SECOND(release_date)
  FROM movies;

/* 
  Функция DATEDIFF в SQL предназначена для определения числа интервалов времени между двумя датами. 
  Например, DATEDIFF можно использовать для вычисления числа дней между двумя датами или числа недель между сегодняшним днем и концом года.
  Функция DATEDIFF возвращает разницу в днях? Для пересчёта в недели нужно разделить на 7?
*/

SELECT title,
       rating,
       DATEDIFF(CURRENT_DATE(), release_date) AS date_diff -- найти разницу в днях между release_date и текущей датой
  FROM movies;

/* Функция DAYNAME предназначена для возврата названия дня недели. */

SELECT title,
       rating,
       DAYNAME(release_date) AS day
  FROM movies;

SELECT UPPER(title) AS title,
       rating,
       release_year,
       UPPER(DAYNAME(release_date)) AS day
  FROM movies
 ORDER BY release_year DESC;

/* Функция MONTHNAME предназначена для возврата названия месяца. */

SELECT title,
       rating,
       MONTHNAME(release_date) AS month
  FROM movies;

SELECT UPPER(title) AS title,
       rating,
       release_year,
       LOWER(MONTHNAME(release_date)) AS month
  FROM movies
 WHERE release_year > 1990
 ORDER BY release_year DESC;

/* 
  Функция MAKEDATE предназначена для преобразования года и дня в новую дату. 
  Тут надо ещё дописать, что 2-й параметр - это день года, он должен быть больше 0. Ну или точнее - это количество дней, которое прибавляется к 1 январю года year (1 параметр) Пример: SELECT MAKEDATE(2015, 366); вернет дату 1 янв.2016 года  
*/

SELECT title,
       rating,
       MAKEDATE(YEAR(CURRENT_DATE()), 90) AS publish_date
  FROM movies;

SELECT UPPER(title) AS title,
       rating,
       MAKEDATE(YEAR(release_date), 90) AS world_publish_date   -- к годам в поле release_date + 90 дней
  FROM movies
  WHERE release_year > 1990;

/* Функция MAKETIME предназначена для преобразования комбинации часов, минут и секунд в время. */

SELECT title,
       rating,
       MAKETIME(09, 49, 00) AS publish_time
  FROM movies;
```

---

>### Выражения

```SQL
/* 
  CASE — это конструкция, которая позволяет сравнивать значения в запросе и возвращать результат в зависимости от совпадения. Она используется для реализации условного выбора данных. 
*/

SELECT title,
       CASE
       WHEN rating > 8 THEN 'Highly Rated'
       WHEN rating > 6 THEN 'Rated Average'
       ELSE 'Low Rated' 
       END AS rating_category
  FROM movies;

SELECT                                                         -- можно ничего не указывать
       CASE
       WHEN rating > 8 THEN CONCAT(title, ' is Highly Rated')
       WHEN rating > 6 THEN CONCAT(title, ' is Rated Average')
       ELSE CONCAT(title, ' is Low Rated') 
       END AS movie
  FROM movies;

/* 
  COALESCE — это функция, которая позволяет возвращать первое ненулевое значение из списка аргументов.
  Данный запрос выбирает заголовки фильмов и жанры из таблицы movies, ограничивая результат до пяти строк, и если значение жанра отсутствует, используется значение unknown.
*/

SELECT title, 
       COALESCE(genre, "unknown") AS genre -- замена null в колонке genre на unknown
  FROM movies
  LIMIT 5;

SELECT movies.title AS movie,
       COALESCE(reviews.comment, "Нет отзыва") AS review
  FROM movies
 LEFT JOIN reviews
    ON reviews.movie_id = movies.id
    WHERE movies.genre = 'Action';

/* 
  NULLIF в SQL — это функция, которая принимает два аргумента и возвращает NULL, если они равны, иначе возвращает первый аргумент. Она используется для предотвращения дублирования значений или для обработки ошибок.
  В этом запросе, функция NULLIF проверяет каждое значение столбца title на равенство 'Unknown' и если совпадает возвращает NULL, иначе возвращает само значение и записывает его в новый столбец title.
*/

SELECT NULLIF(title, 'Unknown') AS title
  FROM movies;

/* 
  IF в SQL — это функция, которая позволяет выполнять условное выполнение запроса. Она используется для реализации условного выбора данных.
  В этом запросе, мы сравниваем значение столбца rating для каждой строки и в зависимости от результата возвращаем 'Highly Rated' если рейтинг больше 8 и 'Low Rated' если нет и записываем результат в новый столбец rating_category.
 */

SELECT title,
       IF(rating > 8, 'Highly Rated', 'Low Rated') AS rating_category
  FROM movies;

SELECT
       IF(rating > 8, CONCAT(title, ' is Highly Rated'), CONCAT(title, ' is Low Rated')) AS movie
  FROM movies;

SELECT CONCAT(release_year, ' - ', title,
       IF (rating > 8, ' is Highly Rated', 
                       ' is Low Rated')) AS movie
  FROM movies
 ORDER BY movie DESC;

SELECT 
    IF (LENGTH(comment) > 10, CONCAT(LEFT(comment,7), '...'), comment) AS movie
  FROM reviews
 ORDER BY comment DESC;
```

---

>### Объединение таблиц

```SQL
/* 
  INNER JOIN в SQL используется для соединения данных из двух и более таблиц по определенному полю. 
  Это позволяет вам выбрать только те строки, которые  из одной таблицы соответствуют определенным строкам в другой таблице 
*/

SELECT movies.title AS movie_title,   
       actors.name as actor_name
  FROM movies
 INNER JOIN actors
    ON actors.movie_id = movies.id;     -- возвращает только общие строки

SELECT movies.title AS title,
       directors.name AS director,
       genres.name AS genre,
       COUNT(reviews.comment) AS reviews_count
 FROM movies
 LEFT JOIN directors
   ON directors.id = movies.id
INNER JOIN genres
   ON genres.id = movies.genre_id
 LEFT JOIN reviews
   ON movies.id = reviews.movie_id
GROUP BY movies.id
ORDER BY title DESC;

SELECT movies.title AS title,
       directors.name AS director,
       genres.name AS genre,
       CASE
       WHEN COUNT(reviews.comment) > 1 THEN CONCAT('Отзывов: ', COUNT(reviews.comment)) 
       END AS reviews
 FROM movies
 LEFT JOIN directors
   ON directors.id = movies.id
INNER JOIN genres
   ON genres.id = movies.genre_id
 LEFT JOIN reviews
   ON movies.id = reviews.movie_id
GROUP BY movies.id
HAVING COUNT(reviews.comment) > 1 AND directors.name = 'Michael Bay'
ORDER BY title DESC;

/* 
  Вы можете сгруппировать фильмы по id фильма и вернуть список актеров для каждого фильма через запятую использовав функцию GROUP_CONCAT
*/

SELECT movies.title AS movie_title,
       GROUP_CONCAT(actors.name) AS actors
  FROM movies
 INNER JOIN actors
    ON actors.movie_id = movies.id
 GROUP BY movies.id;                 -- группировка на 1 строчку фильма несколько актеров

 SELECT movies.title AS title,
       directors.name AS director,
       genres.name AS genre,
       COALESCE(ROUND(AVG(reviews.rating)), 0) AS rating, -- COALESCE заменит   NUll на 0 полученный от среднего рейтинга
       COUNT(reviews.id) AS reviews
 FROM movies
 LEFT JOIN directors
   ON directors.id = movies.id
INNER JOIN genres
   ON genres.id = movies.genre_id
 LEFT JOIN reviews
   ON movies.id = reviews.movie_id
GROUP BY movies.id
ORDER BY title DESC;

SELECT movies.id AS id,
       movies.title AS title,
       directors.name AS director,
       genres.name AS genre,
       COALESCE(ROUND(AVG(reviews.rating)), 0) AS rating,
       COUNT(reviews.id) AS reviews
 FROM movies
 LEFT JOIN directors
   ON directors.id = movies.id
INNER JOIN genres
   ON genres.id = movies.genre_id
 LEFT JOIN reviews
   ON movies.id = reviews.movie_id
WHERE movies.id % 2 = 0
GROUP BY movies.id
ORDER BY movies.id DESC;

/* 
  LEFT JOIN в SQL похож на INNER JOIN, но он возвращает все строки из левой таблицы, даже если нет соответствующих строк в правой таблице. Если соответствующие строки не найдены в правой таблице, значения правой таблицы будут заполнены значением NULL.
  Например, если у вас есть таблица movies и таблица actors, и вы хотите получить список всех фильмов и их актеров, включая фильмы, для которых не указаны актеры, вы можете использовать следующий запрос:
  Этот запрос вернет список всех фильмов и их актеров, включая фильмы, для которых не указаны актеры, в таком случае в поле actor_name будет значение NULL. 
*/

SELECT movies.title AS movie_title,
       actors.name AS actor_name
  FROM movies
  LEFT JOIN actors
    ON movies.id = actors.movie_id;

/* 
  RIGHT JOIN в SQL аналогичен LEFT JOIN, но он возвращает все строки из правой таблицы, даже если нет соответствующих строк в левой таблице. Если соответствующие строки не найдены в левой таблице, значения левой таблицы будут заполнены значением NULL.
  Этот запрос вернет список всех фильмов и их актеров, включая актеров, для которых не указаны фильмы, в таком случае в поле movie_title будет значение NULL. 
*/

SELECT movies.title AS movie_title,
       actors.name AS actor_name
  FROM movies
 RIGHT JOIN actors
    ON movies.id = actors.movie_id;

/* 
  FULL JOIN в SQL — это сочетание LEFT JOIN и RIGHT JOIN. Он возвращает все строки из обеих таблиц, даже если они не совпадают по значению объединяющего ключа. Если строка не совпадает, то значения из соответствующей таблицы будут заполнены значением NULL.
  Этот запрос вернет список всех фильмов и их актеров, включая фильмы и актеров, для которых не указаны актеры и фильмы, в таком случае в поля movie_title, actor_name будут значения NULL. 
*/

SELECT movies.title AS movie_title,
       actors.name AS actor_name
  FROM movies
  FULL JOIN actors
    ON movies.id = actors.movie_id;

/*
  CROSS JOIN в SQL, также известный как умножение таблиц, соединяет каждую строку из одной таблицы с каждой строкой из другой таблицы. Это означает, что все возможные комбинации строк из обеих таблиц будут включены в результат.
  Например этот запрос вернет все возможные комбинации строк из таблицы movies и actors.
  Для каждого фильма в таблице movies будут произведены все возможные комбинации с каждым актером из таблицы actors.
  Это может быть полезно, если у вас есть определенный набор данных, который вы хотите проанализировать или использовать для создания другой таблицы, но обычно он используется редко, так как результирующая таблица может быть очень большой и содержать множество дубликатов данных. 
*/

/* 
Вернет все возможные комбинации пар т.е. строка 1 и все комбинации со строкой 2, строка 2 то же самое и так со всеми строками 
*/

SELECT movies.title, actors.name
FROM movies
CROSS JOIN actors;          

/* 
  Если вы добавите WHERE тогда, CROSS JOIN  (если таблицы movies и actors связаны) вернет тот же результат, что и INNER JOIN:
*/

SELECT movies.title AS movie_title,
       actors.name AS actor_name
  FROM movies
 CROSS JOIN actors
 WHERE movies.id = actors.movie_id;

/* 
  SELF JOIN в SQL — это когда таблица объединяется сама с собой. Это может быть полезно, когда вам нужно сравнить данные в одной и той же таблице.
  Например, если вы хотите найти все фильмы, которые были сняты в один год и в другой год.
  Этот запрос использует JOIN как SELF JOIN для сравнения фильмов в таблице movies по году выпуска. Он использует таблицу movies дважды, первый раз как m1, а второй раз как m2. Затем он объединяет эти две таблицы по году выпуска и исключает фильмы с одинаковым идентификатором. Результатом будет таблица, которая содержит пары различных фильмов, которые были выпущены в один и тот же год.
*/

SELECT m1.title AS movie_1,
       m2.title AS movie_2
  FROM movies m1
  JOIN movies m2
    ON m1.release_year = m2.release_year
   AND m1.id != m2.id;
```

---

>###  Операции с таблицами

```SQL
/* CREATE TABLE — это команда, которая используется для создания таблицы в базе данных. */

CREATE TABLE movies (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre VARCHAR(255),
    rating INT,
    budget INT);

/* 
  ALTER TABLE — это SQL команда, которая используется для изменения структуры существующей таблицы в базе данных.
  Например, можно добавить новый столбец в таблицу, изменить тип данных существующего столбца или удалить столбец.
*/

ALTER TABLE movies
ADD COLUMN box_office INT; -- добавит новый столбец с именем box_office с типом INT в таблицу movies

 
ALTER TABLE movies
MODIFY COLUMN budget BIGINT; -- изменяет тип данных столбца budget на BIGINT


ALTER TABLE movies
DROP COLUMN release_year; -- удаляет столбец release_year из таблицы movies
 

ALTER TABLE movies
RENAME COLUMN box_office TO revenue; -- переименовывает столбец box_office в revenue в таблице movies

/* DROP TABLE — это команда, которая используется для удаления таблицы из базы данных */

DROP TABLE movies;

/* 
  IF EXISTS используется с DROP TABLE для проверки существования таблицы перед удалением.
  Если таблица существует, то она будет удалена. Если же таблицы не существует, то никаких действий не будет произведено.
*/

DROP TABLE IF EXISTS movies;
 
DROP VIEW view_name;  -- Вы также можете использовать команду DROP для удаления представлений таблиц

/* INSERT INTO — это команда, которая используется для добавления новых строк в таблицу. */

INSERT INTO movies (title, release_year, genre, rating, budget)
VALUES ('Inception', 2010, 'Thriller', 8, 160000000),
       ('Pulp Fiction', 1994, 'Crime', 8, 31500000),
       ('Fight Club', 1999, 'Drama', 8, 63000000);

/* UPDATE — это команда, которая используется для изменения данных в существующей таблице. */

UPDATE movies
   SET release_year = 2000,
       genre = 'Action'
 WHERE title = 'The Shawshank Redemption';

/* DELETE — это команда, которая используется для удаления строк из таблицы. */


DELETE FROM movies
 WHERE id IN ( 1, 2, 3 );  -- удалит фильмы с id 1, 2 и 3 из таблицы movies

/* 
  TRUNCATE TABLE — это SQL оператор, который используется для удаления всех строк из таблицы базы данных, но оставляя таблицу и структуру данных неизменными. Это значительно быстрее, чем удаление всех строк одного за другим с помощью DELETE.
*/

TRUNCATE TABLE movies; -- удалит все строки из таблицы movies, но оставит структуру таблицы и ее индексы неизменными

/* SHOW TABLES — это SQL команда, которая используется для вывода списка всех таблиц в базе данных */

SHOW TABLES;   -- вывод таблиц для текущей базы данных.    

SHOW TABLES FROM movies;  -- вывод таблиц для указанной базы данных movies.
```

---
