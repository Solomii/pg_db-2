-- 1nf
CREATE TABLE t1(
  p1 VARCHAR(64)
  p2 INT 
  PRIMARY KEY (p1,p2)
)

--2 nf
-- CREATE TABLE "workers"(
--   id serial PRIMARY KEY,
--   name VARCHAR (64),
--   department VARCHAR(64)
--   position VARCHAR(64)
--   is_car BOOLEAN
-- )

-- INSERT INTO (name, position, is_car)
-- VALUE ('Tom','teacher', false), ('Anna', 'HR', false),('Fred', 'driver',true)

-- CREATE TABLE position(
--   id serial PRIMARY KEY,
--   name VARCHAR (64),
--   is_car BOOLEAN
-- )

-- CREATE TABLE workers(
--   id serial PRIMARY KEY,
--   name VARCHAR (64),
--   department VARCHAR(64)
--   position_id int REFERENCES position.id
-- )

-- INSERT INTO (name, position, is_car)
-- VALUE ('teacher', false), ('HR', false),('driver',true);
-- INSERT INTO workers(name, position_id)
-- VALUE('Tom', 1), ('Anna', 2),('Fred', 3)


