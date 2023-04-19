CREATE TYPE "task_status" AS ENUM ('done','inprocessing', 'reject', 'panding')
DROP TABLE IF EXISTS "users_tasks"
CREATE TABLE "users_tasks" (
  "id" SERIAL PRIMARY KEY,
  "content" text NOT NULL,
  "userId" INT REFERENCES  "users"("id"),
  "status" "task_status" NOT NULL,
  "deadLine" TIMESTAMP NOT NULL DEFAULT current_timestamp
)

INSERT INTO "users_tasks" ("content", "userId","status")
VALUES ('task one',3,'done'),('task second',5,'reject'),('task third',25,'panding')

SELECT * FROM "users_tasks" 

-- add column
ALTER TABLE "users_tasks" 
ADD COLUMN "createAT" TIMESTAMP NOT NULL DEFAULT current_timestamp

ALTER TABLE "users_tasks" 
ADD COLUMN "mark" SMALLINT;

-- drop column
ALTER TABLE "users_tasks" 
DROP COLUMN "mark";

-- add constraint
ALTER TABLE "users_tasks" 
ADD CONSTRAINT "content_check_empty" CHECK("content"!='')

-- drop constraint
ALTER TABLE "users_tasks" 
DROP CONSTRAINT "content_check_empty"

--drop not null
ALTER TABLE "users_tasks" 
ALTER COLUMN "createAT" DROP NOT NULL

--add not null
ALTER TABLE "users_tasks" 
ALTER COLUMN "createAT" SET NOT NULL

--drop default
ALTER TABLE "users_tasks" 
ALTER COLUMN "createAT"  DROP DEFAULT

--add default
ALTER TABLE "users_tasks" 
ALTER COLUMN "createAT" SET DEFAULT current_timestamp

ALTER TABLE "users_tasks" 
ALTER COLUMN "content" TYPE VARCHAR(128)

ALTER TABLE "users_tasks"
RENAME COLUMN "content" to "contentBody"

SELECT * FROM "users_tasks"