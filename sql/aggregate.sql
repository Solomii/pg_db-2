-- порахувати скільки загалом продали телефонів

SELECT sum("quantity")
FROM "phones_to_orders"

--знайти середню ціну усіх телефонів
SELECT avg("price")
FROM "phones"

-- знайти середню ціну кожного бренду
SELECT avg("price"),"brand"
FROM "phones"
GROUP BY "brand"

-- знайти кількість моделей для кожного бренду
SELECT count(*),"brand"
FROM "phones"
GROUP BY "brand"

-- знайти мінімальну ціну тел. 
SELECT min("price")
FROM "phones"

-- знайти мінімальну ціну тел.  по брендач
SELECT min("price"), "brand"
FROM "phones"
GROUP BY "brand"

--кількість замовлень длч кожного користувача юзера, який робив замовлення(id, count)
SELECT count("id"), "userId"
FROM "orders"
GROUP BY "userId"

-- яка загальна ціна усіх телеф. в соні на складі
SELECT sum("price"*"quantity"), "brand"
FROM "phones"
WHERE "brand"='Sony' 
GROUP BY "brand"

