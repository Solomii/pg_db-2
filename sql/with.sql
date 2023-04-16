-- обрати замовлення з чеком вище середнього 
-- 1 - порахувати чек кожного замовлення id, quantity phones
SELECT "pto"."orderId",
  sum("pto"."quantity" * "p"."price") AS "check"
FROM "phones_to_orders" AS "pto"
  JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
GROUP BY "pto"."orderId"
ORDER BY "check" DESC -- знайти середній чек 
SELECT avg("orders_check"."check")
FROM (
    SELECT "pto"."orderId",
      sum("pto"."quantity" * "p"."price") AS "check"
    FROM "phones_to_orders" AS "pto"
      JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
    GROUP BY "pto"."orderId"
  ) AS "orders_check" --обрати замовлення з чеком вище середнього 
SELECT "orders_check".*
FROM (
    SELECT "pto"."orderId",
      sum("pto"."quantity" * "p"."price") AS "check"
    FROM "phones_to_orders" AS "pto"
      JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
    GROUP BY "pto"."orderId"
  ) AS "orders_check"
WHERE "orders_check"."check" > (
    SELECT avg("orders_check"."check")
    FROM (
        SELECT "pto"."orderId",
          sum("pto"."quantity" * "p"."price") AS "check"
        FROM "phones_to_orders" AS "pto"
          JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
        GROUP BY "pto"."orderId"
      ) AS "orders_check"
  )
ORDER BY "orders_check"."check";
WITH "orders_check" AS (
  SELECT "pto"."orderId",
    sum("pto"."quantity" * "p"."price") AS "check"
  FROM "phones_to_orders" AS "pto"
    JOIN "phones" AS "p" ON "pto"."phoneId" = "p"."id"
  GROUP BY "pto"."orderId"
)
SELECT "oc".*
FROM "orders_check" AS "oc"
WHERE "oc"."check" > (
    SELECT avg("oc"."check")
    FROM "orders_check" AS "oc"
  )
ORDER BY "oc"."check" 
--отримати пошту усіх користувачів, у яких замовлень менше середньої кількості
  WITH "order_count" AS (
    SELECT "u"."email" AS "email",
      count("o"."id") AS "count"
    FROM "users" AS "u"
      JOIN "orders" AS "o" ON "u"."id" = "o"."userId"
    GROUP BY "u"."email"
  )
  SELECT "oc".*
  FROM "order_count" AS "oc"
  WHERE "oc"."count" < (SELECT avg("oc"."count") FROM "order_count" AS "oc")
  ORDER BY "oc"."count", "oc"."email"
  LIMIT 5 OFFSET 15