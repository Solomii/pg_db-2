-- пошта, кількість замовлень, загальна сума

SELECT "o"."id", "u"."email", count("o"."userId")  OVER(PARTITION BY "o"."userId" ORDER BY "o"."id" ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "total_count"
FROM "users" AS "u"
  JOIN "orders" AS "o" ON "u"."id"="o"."userId" 
GROUP BY "o"."id", "u"."email"


-- вибрати телефон(айді, модель), айді замовлення, сумарний чек замовлення
-- відсортувати за айді телефона
SELECT "p"."id", "p"."model", sum("p"."price"*"pto"."quantity")  OVER(PARTITION BY "pto"."orderId"  ORDER BY "p"."id"  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "total_sum"
FROM "phones" AS "p"
  JOIN "phones_to_orders" AS "pto" ON "p"."id"="pto"."phoneId" 