INSERT INTO cities (name) VALUES
('Москва'),
('Тула'),
('Калуга'),
('Рязань'),
('Воронеж');

INSERT INTO bus_stops (city_id, name) VALUES
(1, 'Автовокзал'),
(1, 'Южные ворота'),
(2, 'Автовокзал'),
(2, 'Площадь Ленина'),
(3, 'Автовокзал'),
(3, 'Центральная площадь'),
(4, 'Автовокзал'),
(4, 'Железнодорожный вокзал'),
(5, 'Автовокзал'),
(5, 'Центральная площадь');

INSERT INTO buses (registration_no, model, capacity)
SELECT
'A-' || LPAD(i::text, 3, '0'),
CASE
WHEN i % 2 = 0 THEN 'ЛиАЗ-5292'
ELSE 'МАЗ-203'
END,
45
FROM generate_series(1, 20) AS i;


INSERT INTO trips (bus_id, route_number, departure_at)
VALUES
(1,  '101', CURRENT_TIMESTAMP + INTERVAL '10 minutes'),
(2,  '102', CURRENT_TIMESTAMP + INTERVAL '25 minutes'),
(3,  '103', CURRENT_TIMESTAMP + INTERVAL '40 minutes'),
(4,  '104', CURRENT_TIMESTAMP + INTERVAL '55 minutes'),
(5,  '105', CURRENT_TIMESTAMP + INTERVAL '70 minutes'),
(6,  '106', CURRENT_TIMESTAMP + INTERVAL '85 minutes'),
(7,  '107', CURRENT_TIMESTAMP + INTERVAL '100 minutes'),
(8,  '108', CURRENT_TIMESTAMP + INTERVAL '115 minutes'),
(9,  '109', CURRENT_TIMESTAMP + INTERVAL '130 minutes'),
(10, '110', CURRENT_TIMESTAMP + INTERVAL '145 minutes'),
(11, '111', CURRENT_TIMESTAMP + INTERVAL '160 minutes'),
(12, '112', CURRENT_TIMESTAMP + INTERVAL '175 minutes'),
(13, '113', CURRENT_TIMESTAMP + INTERVAL '190 minutes'),
(14, '114', CURRENT_TIMESTAMP + INTERVAL '205 minutes'),
(15, '115', CURRENT_TIMESTAMP + INTERVAL '220 minutes'),
(16, '116', CURRENT_TIMESTAMP + INTERVAL '235 minutes'),
(17, '117', CURRENT_TIMESTAMP + INTERVAL '250 minutes'),
(18, '118', CURRENT_TIMESTAMP + INTERVAL '265 minutes'),
(19, '119', CURRENT_TIMESTAMP + INTERVAL '280 minutes'),
(20, '120', CURRENT_TIMESTAMP + INTERVAL '295 minutes');


INSERT INTO trips (bus_id, route_number, departure_at)
VALUES
(1, '201', CURRENT_TIMESTAMP - INTERVAL '60 minutes'),
(2, '202', CURRENT_TIMESTAMP - INTERVAL '30 minutes');

INSERT INTO trip_stops (
trip_id,
stop_id,
stop_order,
arrival_at,
departure_at
)
VALUES
(1, 1, 1, CURRENT_TIMESTAMP + INTERVAL '10 minutes',
CURRENT_TIMESTAMP + INTERVAL '15 minutes'),
(1, 3, 2, CURRENT_TIMESTAMP + INTERVAL '100 minutes',
CURRENT_TIMESTAMP + INTERVAL '105 minutes'),
(1, 5, 3, CURRENT_TIMESTAMP + INTERVAL '160 minutes',
CURRENT_TIMESTAMP + INTERVAL '160 minutes');

INSERT INTO trip_stops VALUES
(2, 1, 1, CURRENT_TIMESTAMP + INTERVAL '25 minutes',
CURRENT_TIMESTAMP + INTERVAL '30 minutes'),
(2, 7, 2, CURRENT_TIMESTAMP + INTERVAL '150 minutes',
CURRENT_TIMESTAMP + INTERVAL '150 minutes');

INSERT INTO trip_stops (
trip_id,
stop_id,
stop_order,
arrival_at,
departure_at
)
SELECT
t.id,
1,
1,
t.departure_at,
t.departure_at + INTERVAL '5 minutes'
FROM trips t
WHERE t.id BETWEEN 3 AND 20;

INSERT INTO trip_stops (
trip_id,
stop_id,
stop_order,
arrival_at,
departure_at
)
SELECT
t.id,
1,
1,
t.departure_at,
t.departure_at + INTERVAL '5 minutes'
FROM trips t
WHERE t.id BETWEEN 21 AND 22;

ANALYZE;
