DROP VIEW IF EXISTS "email_seasonBD" 
CREATE VIEW "email_seasonBD" AS (
  SELECT (
    CASE extract("month" FROM "birthday")
    WHEN 1 THEN 'winter'
    WHEN 2 THEN 'winter'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    END
  ) AS "season", "birthday","email"
  FROM "users"
) 

SELECT "season", count(*)
FROM "email_seasonBD"
GROUP BY "season"

-- створити вюшку, яка б діставала усе про юзера і додатково колонку з кількістю замовлень юзера


-- CREATE VIEW "quantity_of_orders" AS 

CREATE OR REPLACE VIEW "user_order_count"  AS (
  SELECT "u".*, count("o".*)
  FROM "users" AS "u"
   JOIN "orders" AS "o" ON "u"."id"="o"."userId"
   GROUP BY "u"."id"
)

-- користувачі якого сезону народження роблять найбільше замовлень

SELECT "es"."season", sum("uoc"."count") AS "sum"
FROM "email_seasonBD" AS "es"
  JOIN "user_order_count" AS "uoc" ON "es"."id"="uoc"."id"
GROUP BY "es"."season"
ORDER BY "sum"
LIMIT 1

--створити вьюшку в якій буде замовлення і чек замовлення

CREATE VIEW "order_check"  AS (
  SELECT "o".*, sum("p"."price"*"pto"."quantity")
  FROM "orders" AS "o"
   JOIN "phones_to_orders" AS "pto" ON "o"."id" ="pto"."orderId"
   JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
 GROUP BY "o"."id"  
)


--отримати пошту користувача з найбільшим чеком