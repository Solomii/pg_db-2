CREATE SCHEMA "local";
CREATE TABLE "local"."users"(
  "id" SERIAL PRIMARY KEY,
  "login" VARCHAR(64) NOT NULL CHECK("login"!=''),
  "password" VARCHAR(64) NOT NULL CHECK("password"!=''),
  "email" VARCHAR(64) UNIQUE NOT NULL CHECK("email"!='')
)

CREATE TABLE "local"."tasks"(
  "id" SERIAL PRIMARY KEY,
  "content" VARCHAR(64),
  "userId" INT REFERENCES "local"."users"("id")
)

CREATE TABLE "local"."roles"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(64)
)

-- додати обмеження унікальності для "name"
ALTER TABLE "local"."roles" 
ADD CONSTRAINT "unique_name" UNIQUE("name");
-- вставити пару записів в таблицю ролей
INSERT INTO "local"."roles"("name")
VALUES ('testRole1'),
('testRole2'),
('testRole3')
--додати звязок між таблицями "local"."users" and  "local"."roles"

ALTER TABLE "local"."users" 
DROP COLUMN "rolesId"


INSERT INTO "local"."users"("login",  "password", "email")
VALUES ('test1', 'test1', 'testuser@gamil1.com'),
('test1', 'test2', 'testuser@gamil2.com'),
('test3', 'test3', 'testuser@gamil3.com')


INSERT INTO "local"."tasks"("content", "userId")
VALUES ('testSchema1 test', 1),
('testSchema2 test', 2),
('testSchema3 test', 3)



--додати обмеження до "content" NOT NULL та не порожнє
ALTER TABLE "local"."tasks" 
ALTER COLUMN "content" SET NOT NULL;
ALTER TABLE "local"."tasks" 
ADD CONSTRAINT "check_empty_content" CHECK("content"!='')
--додати нову колонку createdAt з обмеженням  NOT NULL
--переіменуйте поле  "password" на  "passwordHash" і змініть йому тип данних на TEXT

ALTER TABLE "local"."tasks" 
ADD COLUMN  "createdAt" TIMESTAMP NOT NULL DEFAULT current_timestamp;

ALTER TABLE "local"."users"
RENAME COLUMN "password" to "passwordHash"

ALTER TABLE "local"."users"
ALTER COLUMN "passwordHash" TYPE TEXT

SELECT * FROM "local"."users"

-- DROP TABLE "local"."users"