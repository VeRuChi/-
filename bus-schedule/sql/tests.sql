-- Проверка схемы и основного запроса.


SELECT COUNT(*) AS cities_count
FROM cities;

-- Ожидается: 5


SELECT COUNT(*) AS buses_count
FROM buses;

-- Ожидается: 20


SELECT
COUNT(*) AS future_trips
FROM trips
WHERE departure_at >= CURRENT_TIMESTAMP;


SELECT
t.route_number,
ts.departure_at
FROM trip_stops AS ts
JOIN trips AS t
ON t.id = ts.trip_id
WHERE ts.stop_id = 1
AND ts.departure_at >= CURRENT_TIMESTAMP
ORDER BY ts.departure_at
LIMIT 15;

-- Должно быть не более 15 записей.
-- Все записи должны быть отсортированы по departure_at.


SELECT
COUNT(*) AS invalid_rows
FROM trip_stops AS ts
WHERE ts.stop_id = 1
AND ts.departure_at < CURRENT_TIMESTAMP;

-- Эти записи существуют в БД, но не должны попадать в результат основного запроса.


EXPLAIN (ANALYZE, BUFFERS)
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

-- При небольшом количестве данных PostgreSQL может выбрать
-- последовательное сканирование вместо индекса.


## -- На большой таблице ожидается использование:

## -- idx_trip_stops_stop_departure

-- Фактический план зависит от статистики и стоимости операций.
