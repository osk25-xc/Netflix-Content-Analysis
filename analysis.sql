-- Netflix Content Analysis | PostgreSQL
-- Fictional sample catalogue for SQL learning; not a full Netflix export.
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
 title_id INT PRIMARY KEY, title VARCHAR(100), content_type VARCHAR(15),
 release_year INT, date_added DATE, country VARCHAR(35), genre VARCHAR(35),
 rating VARCHAR(12), duration_minutes INT
);
INSERT INTO titles VALUES
(1,'City of Echoes','Movie',2022,'2023-01-10','India','Drama','U/A 13+',118),
(2,'Deep Blue Files','TV Show',2021,'2023-02-14','United States','Documentary','U/A 16+',NULL),
(3,'Monsoon Letters','Movie',2020,'2023-03-05','India','Romance','U',106),
(4,'The Last Signal','TV Show',2024,'2024-01-12','United Kingdom','Thriller','A',NULL),
(5,'Kitchen Stories','TV Show',2019,'2024-02-18','India','Reality','U',NULL),
(6,'Orbit Nine','Movie',2023,'2024-04-22','United States','Sci-Fi','U/A 13+',132),
(7,'Hidden Coast','Movie',2018,'2024-06-01','Australia','Drama','U/A 16+',124),
(8,'Code of Silence','TV Show',2022,'2024-07-17','India','Thriller','A',NULL),
(9,'Little Explorers','TV Show',2020,'2025-01-03','Canada','Kids','U',NULL),
(10,'Paper Kingdom','Movie',2025,'2025-02-10','United Kingdom','Drama','U/A 13+',111),
(11,'Wild Planet','TV Show',2023,'2025-04-11','Australia','Documentary','U',NULL),
(12,'Final Over','Movie',2021,'2025-05-19','India','Sports','U',104);
-- 1. Catalogue overview
SELECT COUNT(*) AS titles, COUNT(*) FILTER (WHERE content_type='Movie') AS movies,
 COUNT(*) FILTER (WHERE content_type='TV Show') AS tv_shows FROM titles;
-- 2. Content added by year
SELECT EXTRACT(YEAR FROM date_added) AS added_year, COUNT(*) AS titles
FROM titles GROUP BY 1 ORDER BY 1;
-- 3. Release-year trend
SELECT release_year, COUNT(*) AS titles FROM titles GROUP BY release_year ORDER BY release_year;
-- 4. Genre distribution
SELECT genre, COUNT(*) AS titles FROM titles GROUP BY genre ORDER BY titles DESC;
-- 5. Country catalogue mix
SELECT country, COUNT(*) AS titles FROM titles GROUP BY country ORDER BY titles DESC;
-- 6. Movie runtime distribution
SELECT CASE WHEN duration_minutes<100 THEN 'Under 100 min'
 WHEN duration_minutes<120 THEN '100-119 min' ELSE '120+ min' END AS runtime_band,
 COUNT(*) AS movies FROM titles WHERE content_type='Movie' GROUP BY 1;
-- 7. Maturity rating mix
SELECT rating, COUNT(*) AS titles FROM titles GROUP BY rating ORDER BY titles DESC;
-- 8. Genre by content type
SELECT genre, content_type, COUNT(*) AS titles
FROM titles GROUP BY genre,content_type ORDER BY genre,titles DESC;
