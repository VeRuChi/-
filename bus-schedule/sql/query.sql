## -- Электронное табло.

## -- :stop_id — ID остановки.

-- Пример:
-- stop_id = 1
--------------

-- Показываем следующие 15 рейсов,
-- которые ещё не отправились.

SELECT
t.route_number,
c.name AS city,
bs.name AS stop_name,
ts.departure_at,
b.registration_no,
b.model
FROM trip_stops AS ts
JOIN trips AS t
ON t.id = ts.trip_id
JOIN bus_stops AS bs
ON bs.id = ts.stop_id
JOIN cities AS c
ON c.id = bs.city_id
JOIN buses AS b
ON b.id = t.bus_id
WHERE ts.stop_id = 1
AND ts.departure_at >= CURRENT_TIMESTAMP
ORDER BY ts.departure_at
LIMIT 15;

## -- Для анализа плана выполнения:

-- EXPLAIN (ANALYZE, BUFFERS)
-- SELECT ...
-------------

## -- Ожидается использование:

## -- idx_trip_stops_stop_departure

## -- Индекс соответствует:

-- WHERE stop_id = 1
-- ORDER BY departure_at
------------------------

-- Благодаря LIMIT 15 PostgreSQL может остановить
-- чтение индекса после получения необходимых строк.
