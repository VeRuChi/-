DROP TABLE IF EXISTS trip_stops;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS bus_stops;
DROP TABLE IF EXISTS cities;


CREATE TABLE cities (
id   BIGSERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE bus_stops (
id      BIGSERIAL PRIMARY KEY,
city_id BIGINT NOT NULL REFERENCES cities(id),
name    VARCHAR(150) NOT NULL,


UNIQUE (city_id, name)


);

CREATE TABLE buses (
id              BIGSERIAL PRIMARY KEY,
registration_no VARCHAR(20) NOT NULL UNIQUE,
model           VARCHAR(100) NOT NULL,
capacity        INTEGER NOT NULL CHECK (capacity > 0)
);

CREATE TABLE trips (
id             BIGSERIAL PRIMARY KEY,
bus_id         BIGINT NOT NULL REFERENCES buses(id),
route_number   VARCHAR(20) NOT NULL,
departure_at   TIMESTAMP NOT NULL,


UNIQUE (route_number, departure_at)


);


CREATE TABLE trip_stops (
trip_id      BIGINT NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
stop_id      BIGINT NOT NULL REFERENCES bus_stops(id),
stop_order   INTEGER NOT NULL CHECK (stop_order > 0),
arrival_at   TIMESTAMP NOT NULL,
departure_at TIMESTAMP NOT NULL,


PRIMARY KEY (trip_id, stop_order),

UNIQUE (trip_id, stop_id),

CHECK (departure_at >= arrival_at)


);

## -- Основной индекс для электронного табло.
CREATE INDEX idx_trip_stops_stop_departure
ON trip_stops (stop_id, departure_at);

CREATE INDEX idx_trip_stops_trip_id
ON trip_stops (trip_id);

CREATE INDEX idx_trips_bus_id
ON trips (bus_id);

CREATE INDEX idx_bus_stops_city_id
ON bus_stops (city_id);
