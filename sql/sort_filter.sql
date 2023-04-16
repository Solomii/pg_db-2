SELECT "id", "firstName", "lastName", "birthday"
FROM "users"
ORDER BY "lastName" ASC, "firstName" DESC

SELECT "id", "firstName", "lastName", "birthday"
FROM "users"
ORDER BY "birthday" DESC
LIMIT 1 

--виведіть email 10 і age відсортовані за полем age
SELECT "id", "email", extract("years" FROM age("birthday")) AS "age"
FROM "users"
ORDER BY "age"
LIMIT 10

-- порахувати скільки людей у нас певного віку
SELECT count("id") AS "count", extract("years" FROM age("birthday")) AS "age"
FROM "users"
GROUP BY "age"
HAVING count("id") =2
ORDER BY "count" DESC, "age" DESC

--вивести ті бренди, в яких загальна кількість тел. менше 5000
SELECT sum("quantity") AS sum, "brand"
FROM "phones"
GROUP BY "brand"
HAVING sum("quantity") <7000 
ORDER BY  "sum"

-- порахувати всіх людей імя яки починається на літеру А
SELECT count("id") AS count
FROM "users"
WHERE "firstName" LIKE 'A%'

SELECT "firstName"
FROM "users"
WHERE "firstName" LIKE 'A%'

SELECT "firstName"
FROM "users"
WHERE "firstName" LIKE '_e%'

SELECT "firstName"
FROM "users"
WHERE "firstName" ILIKE '_e%e'

SELECT "firstName"
FROM "users"
WHERE "firstName" SIMILAR TO '%S{2}%'

-- знайти і вивести людей з ініцілами DS
SELECT "firstName", "lastName"
FROM "users"
WHERE "firstName" LIKE 'A%'  AND "lastName" LIKE 'A%'
