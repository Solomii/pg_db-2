
-- -- вивести id усіх юзерів, які робили замовлення 
-- SELECT "id" 
-- FROM "users"
-- INTERSECT 
-- SELECT "userId" 
-- FROM "orders"

-- -- вивести id усіх юзерів, які робили не замовлення 
-- SELECT "id" 
-- FROM "users"
-- EXCLUSIVE
-- SELECT "userId" 
-- FROM "orders"

SELECT "u"."id", "email", count(*)
FROM "users" AS "u"
 JOIN "orders" AS "o" ON "u"."id"="o"."userId"
-- WHERE "u"."id"%2 = 1
GROUP BY "u"."id", "email"
HAVING count(*)>3

-- всі id в якич купували Sony
SELECT "o"."id", "p"."brand", "p"."model"
FROM "orders" AS "o"
 JOIN "phones_to_orders" AS "pto" ON "o"."id"="pto"."orderId"
 JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
WHERE  "p"."brand" ILIKE 'sony'
ORDER BY "o"."id", "p"."model"

-- кількість моделей sony для кожного замовлення, перший варіант
SELECT "o"."id", count("p"."model"), "p"."brand"
FROM "orders" AS "o"
 JOIN "phones_to_orders" AS "pto" ON "o"."id"="pto"."orderId"
 JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
WHERE  "p"."brand" ILIKE 'sony'
GROUP BY "o"."id", "p"."brand"
ORDER BY "o"."id"

-- другий варіант
SELECT "pto"."orderId", count("p"."model"), "p"."brand"
FROM "phones_to_orders" AS "pto"
 JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
WHERE  "p"."brand" ILIKE 'sony'
GROUP BY "pto"."orderId", "p"."brand"
ORDER BY "pto"."orderId"


-- кількість проданих телефонів по кожній модель
SELECT sum("pto"."quantity") AS "amount", "p"."model", "p"."brand"
FROM "phones_to_orders" AS "pto"
 JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
GROUP BY "p"."brand", "p"."model"
ORDER BY "amount" DESC
LIMIT 1


-- вивести телефони, які купляли
SELECT "phones"."id", "phones"."brand"
FROM "phones"
  JOIN "phones_to_orders" AS "pto" ON "phones"."id"="pto"."phoneId"
GROUP BY "phones"."id"
ORDER BY "phones"."id"

-- вивести бренди телефони, які купляли
SELECT  DISTINCT "phones"."brand"
FROM "phones"
  JOIN "phones_to_orders" AS "pto" ON "phones"."id"="pto"."phoneId"
-- GROUP BY "phones"."brand"
ORDER BY "phones"."brand"

-- вивести бренди телефони, які НЕ купляли
SELECT  "p"."brand"
FROM "phones" AS "p"
  LEFT OUTER JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId"
WHERE "pto"."phoneId" IS NULL

-- вивести model телефони, які НЕ купляли
SELECT  "p"."model"
FROM "phones" AS "p"
  LEFT OUTER JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId"
WHERE "pto"."phoneId" IS NULL

-- вивести email телефони, які НЕ робили замовлення
SELECT  "u"."email"
FROM "users" AS "u"
  RIGHT OUTER JOIN "orders" AS "o" ON "u"."id"="o"."userId"
WHERE "o"."userId" IS NULL
GROUP BY "u"."email"

-- вивести користувачів, які купляли айфон
SELECT DISTINCT "u"."email", "p"."brand"
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId"
  JOIN "phones_to_orders" AS "pto" ON "o"."userId"="pto"."orderId"
  JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
WHERE "p"."brand" LIKE 'Iphone'

-- вивести користувачів, які зробили тільки по одному замовленню
SELECT DISTINCT "u"."email", count("o"."id")
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId"
GROUP BY "u"."email"
HAVING count("o"."id")=1

-- вивести усі id замовлень і email користувачів, де купували телефон з id=8
SELECT "u"."email", "pto"."orderId"
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId"
  JOIN "phones_to_orders" AS "pto" ON "o"."userId"="pto"."orderId"
WHERE "pto"."orderId"=8  


-- вивести модель найпопулярнішого телефону - якого продали більшу кількість
SELECT "p"."model", sum("pto"."quantity")
FROM "phones_to_orders" AS "pto" 
  JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
GROUP BY "p"."model"  
ORDER BY sum("pto"."quantity") DESC
LIMIT 1

--вивести користувача з кількістю моделей, яку він купив
-- email 1 моделі відсортовані по моделях
-- рахуємо кількість
SELECT DISTINCT "u"."email",count("p"."model")  
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId"
  JOIN "phones_to_orders" AS "pto" ON "o"."userId"="pto"."orderId"
  JOIN "phones" AS "p" ON "pto"."phoneId"="p"."id"
GROUP BY  "u"."email"
HAVING count("p"."model") <10
ORDER BY "u"."email"