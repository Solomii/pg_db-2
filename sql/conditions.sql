
--якщо бренд телефону iphone повернути 'Apple', інакше повернути 'Other'
SELECT "model", "brand", (
  CASE
   WHEN "brand" LIKE 'iphone' THEN 'Apple'
   ELSE 'Other'
  END 
) AS "nameBrand"
FROM "phones"

--вивести колонку доступність ціни:
-- якщо ціна менше 3000 виводимо слово дешевий
-- якщо ціна від 3000 до 7000 виводимо слово середній
-- якщо ціна вище 7000 виводимо слово високий


SELECT "model", "price", (
  CASE
   WHEN "price" <=3000 THEN 'cheep'
    WHEN "price" >=3000 AND "price" <=10000 THEN 'more'
   ELSE 'Other'
  END 
) AS "nameBrand"
FROM "phones"

--вивести колонку яка повідомляє чи ціна телефона вище середньої або нижче
 
SELECT *
FROM  "users"
WHERE "users"."id" IN (SELECT "userId" FROM "orders")

SELECT *
FROM  "users"
WHERE "users"."id"  NOT IN (SELECT "userId" FROM "orders")

-- обрпти усі моделі телефоні, які купляли
SELECT *
FROM  "phones"
WHERE "phones"."id" IN (SELECT "phoneId" FROM "phones_to_orders")

-- обрати усі моделі тел., які НЕ купляли
SELECT *
FROM  "phones"
WHERE "phones"."id"  NOT IN (SELECT "phoneId" FROM "phones_to_orders")

SELECT *
FROM  "users"
WHERE "users"."id"  !=ALL (SELECT "userId" FROM "orders")