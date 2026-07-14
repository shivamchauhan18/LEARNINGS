# 1.Display snum,sname,city and comm of all salespeople.

SELECT * FROM SALESPEOPLE;

# 2.Display all snum without duplicates from all orders.

SELECT distinct(SNUM) FROM ORDERS;

# 3.Display names and commissions of all salespeople in london.

SELECT SNAME, COMM FROM SALESPEOPLE
WHERE CITY = "LONDON";

# 4.All customers with rating of 100.

SELECT * FROM CUST WHERE RATING = 100;


# 5.Produce orderno, amount and date from all rows in the order table.
SELECT ONUM, AMT, ODATE FROM ORDERS 

# 6. All customers in San Jose who have rating more than 200.
SELECT *
FROM CUST
WHERE CITY = 'San Jose'
  AND RATING > 200;

# 7. All customers who were either located in San Jose or had a rating above 200.
SELECT *
FROM CUST
WHERE CITY = 'San Jose'
   OR RATING > 200;

# 8. All orders for more than $1000.
SELECT *
FROM ORDERS
WHERE AMT > 1000;

# 9. Names and cities of all salespeople in London with commission above 0.10.
SELECT SNAME, CITY
FROM SALESPEOPLE
WHERE CITY = 'London'
  AND COMM > 0.10;
    

# 10. All customers excluding those with rating <= 100 unless they are located in Rome.
SELECT *
FROM CUST
WHERE RATING > 100
   OR CITY = 'Rome';

# 11. All salespeople either in Barcelona or in London.
SELECT *
FROM SALESPEOPLE
WHERE CITY = 'Barcelona'
   OR CITY = 'London';

# 12. All salespeople with commission between 0.10 and 0.12 (excluding boundary values).
SELECT *
FROM SALESPEOPLE
WHERE COMM > 0.10
  AND COMM < 0.12;

# 13. All customers with NULL values in the CITY column.
SELECT *
FROM CUST
WHERE CITY IS NULL;

# 14. All orders taken on Oct 3rd and Oct 4th, 1994.
SELECT *
FROM ORDERS
WHERE ODATE IN ('1994-10-03', '1994-10-04');

# 15. All customers serviced by Peel or Motika.
SELECT *
FROM CUST
WHERE SNUM IN (
    SELECT SNUM
    FROM SALESPEOPLE
    WHERE SNAME = 'Peel'
       OR SNAME = 'Motika'
);

# 16. All customers whose names begin with a letter from A to B.
SELECT *
FROM CUST
WHERE CNAME LIKE 'A%'
   OR CNAME LIKE 'B%';

# 17. All orders except those with 0 or NULL value in AMT field.
SELECT *
FROM ORDERS
WHERE AMT IS NOT NULL
  AND AMT <> 0;

# 18. Count the number of salespeople currently listing orders in the ORDERS table.
SELECT COUNT(DISTINCT SNUM) AS TOTAL_SALESPEOPLE
FROM ORDERS;

# 19. Largest order taken by each salesperson, datewise.
SELECT SNUM, ODATE, MAX(AMT) AS LARGEST_ORDER
FROM ORDERS
GROUP BY SNUM, ODATE;

# 20. Largest order taken by each salesperson with order value more than $3000.
SELECT SNUM, MAX(AMT) AS LARGEST_ORDER
FROM ORDERS
GROUP BY SNUM
HAVING MAX(AMT) > 3000;

# 21. Which day had the highest total amount ordered.
SELECT ODATE, SUM(AMT) AS TOTAL_AMOUNT
FROM ORDERS
GROUP BY ODATE
ORDER BY TOTAL_AMOUNT DESC
LIMIT 1;

# 22. Count all orders for Oct 3rd.
SELECT COUNT(*) AS TOTAL_ORDERS
FROM ORDERS
WHERE ODATE = '1994-10-03';

# 23. Count the number of different non-NULL city values in the customers table.
SELECT COUNT(DISTINCT CITY) AS TOTAL_CITIES
FROM CUST
WHERE CITY IS NOT NULL;

# 24. Select each customer's smallest order.
SELECT CNUM, MIN(AMT) AS SMALLEST_ORDER
FROM ORDERS
GROUP BY CNUM;

# 25. First customer in alphabetical order whose name begins with G.
SELECT *
FROM CUST
WHERE CNAME LIKE 'G%'
ORDER BY CNAME
LIMIT 1;

# 26. Get the output like "For dd/mm/yy there are ___ orders."
SELECT CONCAT(
    'For ',
    DATE_FORMAT(ODATE, '%d/%m/%y'),
    ' there are ',
    COUNT(*),
    ' orders.'
) AS RESULT
FROM ORDERS
GROUP BY ODATE;

# 27. Assume that each salesperson has a 12% commission.
# Produce order no., salesperson no., and amount of salesperson's commission for that order.
SELECT ONUM,
       SNUM,
       AMT,
       (AMT * 0.12) AS COMMISSION
FROM ORDERS;

# 28. Find highest rating in each city.
# Output: "For the city (city), the highest rating is : (rating)."
SELECT CONCAT(
    'For the city ',
    CITY,
    ', the highest rating is : ',
    MAX(RATING)
) AS RESULT
FROM CUST
GROUP BY CITY;

# 29. Display the totals of orders for each day and place the results in descending order.

SELECT ODATE, SUM(AMT) AS TOTAL_ORDERS
FROM ORDERS
GROUP BY ODATE
ORDER BY TOTAL_ORDERS DESC;


# 30. All combinations of salespeople and customers who shared a city. (i.e., same city)

SELECT S.SNAME, C.CNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C
ON S.CITY = C.CITY;

# 31. Name of all customers matched with the salespeople serving them.

SELECT C.CNAME, S.SNAME
FROM CUST C
JOIN SALESPEOPLE S
ON C.SNUM = S.SNUM;


# 32. List each order number followed by the name of the customer who made the order.

SELECT O.ONUM, C.CNAME
FROM ORDERS O
JOIN CUST C
ON O.CNUM = C.CNUM;


# 33. Names of salesperson and customer for each order after the order number.

SELECT O.ONUM, S.SNAME, C.CNAME
FROM ORDERS O
JOIN SALESPEOPLE S
ON O.SNUM = S.SNUM
JOIN CUST C
ON O.CNUM = C.CNUM;


# 34. Produce all customers serviced by salespeople with a commission above 12%.

SELECT C.CNAME, S.SNAME, S.COMM
FROM CUST C
JOIN SALESPEOPLE S
ON C.SNUM = S.SNUM
WHERE S.COMM > 0.12;


# 35. Calculate the amount of the salesperson’s commission on each order with a rating above 100.

SELECT O.ONUM, O.AMT, C.RATING,
       (O.AMT * S.COMM) AS COMMISSION
FROM ORDERS O
JOIN CUST C
ON O.CNUM = C.CNUM
JOIN SALESPEOPLE S
ON O.SNUM = S.SNUM
WHERE C.RATING > 100;


# 36. Find all pairs of customers having the same rating.

SELECT C1.CNAME, C2.CNAME, C1.RATING
FROM CUST C1
JOIN CUST C2
ON C1.RATING = C2.RATING
WHERE C1.CNUM <> C2.CNUM;


# 37. Find all pairs of customers having the same rating, each pair coming once only.

SELECT C1.CNAME, C2.CNAME, C1.RATING
FROM CUST C1
JOIN CUST C2
ON C1.RATING = C2.RATING
WHERE C1.CNUM < C2.CNUM;


# 38. Policy is to assign three salespeople to each customer. Display all such combinations.

SELECT C.CNAME, S.SNAME
FROM CUST C
CROSS JOIN SALESPEOPLE S;


# 39. Display all customers located in cities where salesman Serres has customers.

SELECT *
FROM CUST
WHERE CITY IN (
    SELECT C.CITY
    FROM CUST C
    JOIN SALESPEOPLE S
    ON C.SNUM = S.SNUM
    WHERE S.SNAME = 'Serres'
);


# 40. Find all pairs of customers served by a single salesperson.

SELECT C1.CNAME, C2.CNAME, S.SNAME
FROM CUST C1
JOIN CUST C2
ON C1.SNUM = C2.SNUM
JOIN SALESPEOPLE S
ON C1.SNUM = S.SNUM
WHERE C1.CNUM < C2.CNUM;

# 41. Produce all pairs of salespeople who are living in the same city.
# Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.

SELECT S1.SNAME AS SALESPERSON1,
       S2.SNAME AS SALESPERSON2,
       S1.CITY
FROM SALESPEOPLE S1
JOIN SALESPEOPLE S2
ON S1.CITY = S2.CITY
WHERE S1.SNUM < S2.SNUM;

# 42. Produce all pairs of orders by a given customer, name that customer, and eliminate duplicates.

SELECT C.CNAME,
       O1.ONUM AS ORDER1,
       O2.ONUM AS ORDER2
FROM ORDERS O1
JOIN ORDERS O2
ON O1.CNUM = O2.CNUM
JOIN CUST C
ON O1.CNUM = C.CNUM
WHERE O1.ONUM < O2.ONUM;


# 43. Produce names and cities of all customers with the same rating as Hoffman.

SELECT CNAME, CITY
FROM CUST
WHERE RATING = (
    SELECT RATING
    FROM CUST
    WHERE CNAME = 'Hoffman'
);


# 44. Extract all the orders of Motika.

SELECT O.*
FROM ORDERS O
JOIN SALESPEOPLE S
ON O.SNUM = S.SNUM
WHERE S.SNAME = 'Motika';


# 45. All orders credited to the same salesperson who services Hoffman.

SELECT *
FROM ORDERS
WHERE SNUM = (
    SELECT SNUM
    FROM CUST
    WHERE CNAME = 'Hoffman'
);


# 46. All orders that are greater than the average for Oct 4.

SELECT *
FROM ORDERS
WHERE AMT > (
    SELECT AVG(AMT)
    FROM ORDERS
    WHERE ODATE = '1994-10-04'
);


# 47. Find average commission of salespeople in London.

SELECT AVG(COMM) AS AVG_COMMISSION
FROM SALESPEOPLE
WHERE CITY = 'London';


# 48. Find all orders attributed to salespeople servicing customers in London.

SELECT O.*
FROM ORDERS O
WHERE O.SNUM IN (
    SELECT DISTINCT SNUM
    FROM CUST
    WHERE CITY = 'London'
);


# 49. Extract commissions of all salespeople servicing customers in London.

SELECT DISTINCT S.SNAME, S.COMM
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
WHERE C.CITY = 'London';


# 50. Find all customers whose CNUM is 1000 above the SNUM of Serres.

SELECT *
FROM CUST
WHERE CNUM = (
    SELECT SNUM + 1000
    FROM SALESPEOPLE
    WHERE SNAME = 'Serres'
);

# 51. Count the customers with rating above San Jose’s average.

SELECT COUNT(*) AS TOTAL_CUSTOMERS
FROM CUST
WHERE RATING > (
    SELECT AVG(RATING)
    FROM CUST
    WHERE CITY = 'San Jose'
);


# 52. Obtain all orders for the customer named Cisnerous.
# (Assume you don't know the customer number.)

SELECT O.*
FROM ORDERS O
JOIN CUST C
ON O.CNUM = C.CNUM
WHERE C.CNAME = 'Cisnerous';

-- Note: In the given data, there is no customer named 'Cisnerous',
-- so this query will return no rows.


# 53. Produce the names and rating of all customers who have above average orders.

SELECT DISTINCT C.CNAME, C.RATING
FROM CUST C
JOIN ORDERS O
ON C.CNUM = O.CNUM
WHERE O.AMT > (
    SELECT AVG(AMT)
    FROM ORDERS
);


# 54. Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.

SELECT SNUM, SUM(AMT) AS TOTAL_AMOUNT
FROM ORDERS
GROUP BY SNUM
HAVING SUM(AMT) > (
    SELECT MAX(AMT)
    FROM ORDERS
);


# 55. Find all customers with orders on 3rd Oct.

SELECT DISTINCT C.CNAME
FROM CUST C
JOIN ORDERS O
ON C.CNUM = O.CNUM
WHERE O.ODATE = '1994-10-03';


# 56. Find names and numbers of all salespeople who have more than one customer.

SELECT S.SNUM, S.SNAME
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME
HAVING COUNT(C.CNUM) > 1;


# 57. Check if the correct salesperson was credited with each sale.

SELECT O.ONUM,
       O.CNUM,
       O.SNUM AS ORDER_SNUM,
       C.SNUM AS CUSTOMER_SNUM,
       CASE
           WHEN O.SNUM = C.SNUM THEN 'Correct'
           ELSE 'Incorrect'
       END AS STATUS
FROM ORDERS O
JOIN CUST C
ON O.CNUM = C.CNUM;


# 58. Find all orders with above average amounts for their customers.

SELECT O.*
FROM ORDERS O
WHERE O.AMT > (
    SELECT AVG(O2.AMT)
    FROM ORDERS O2
    WHERE O2.CNUM = O.CNUM
);

# 59. Find the sums of the amounts from order table grouped by date, eliminating all those
# dates where the sum was not at least 2000 above the maximum amount.

SELECT ODATE, SUM(AMT) AS TOTAL_AMOUNT
FROM ORDERS
GROUP BY ODATE
HAVING SUM(AMT) >= (
    SELECT MAX(AMT) + 2000
    FROM ORDERS
);


# 60. Find names and numbers of all customers with ratings equal to the maximum for their city.

SELECT CNUM, CNAME
FROM CUST C1
WHERE RATING = (
    SELECT MAX(RATING)
    FROM CUST C2
    WHERE C2.CITY = C1.CITY
);


# 61(a). Find all salespeople who have customers in their cities who they don't service. (Using JOIN)

SELECT DISTINCT S.SNUM, S.SNAME
FROM SALESPEOPLE S
JOIN CUST C1
ON S.CITY = C1.CITY
LEFT JOIN CUST C2
ON S.SNUM = C2.SNUM AND C2.CNUM = C1.CNUM
WHERE C2.CNUM IS NULL;


# 61(b). Find all salespeople who have customers in their cities who they don't service. (Using Correlated Subquery)

SELECT *
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT *
    FROM CUST C
    WHERE C.CITY = S.CITY
      AND C.SNUM <> S.SNUM
);


# 62. Extract CNUM, CNAME and CITY from customer table if and only if one or more customers are located in San Jose.

SELECT CNUM, CNAME, CITY
FROM CUST
WHERE EXISTS (
    SELECT *
    FROM CUST
    WHERE CITY = 'San Jose'
);


# 63. Find salesperson numbers who have multiple customers.

SELECT SNUM
FROM CUST
GROUP BY SNUM
HAVING COUNT(*) > 1;


# 64. Find salesperson number, name and city who have multiple customers.

SELECT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME, S.CITY
HAVING COUNT(C.CNUM) > 1;


# 65. Find salespeople who serve only one customer.

SELECT S.SNUM, S.SNAME
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME
HAVING COUNT(C.CNUM) = 1;


# 66. Extract rows of all salespeople with more than one current order.

SELECT S.*
FROM SALESPEOPLE S
JOIN ORDERS O
ON S.SNUM = O.SNUM
GROUP BY S.SNUM, S.SNAME, S.CITY, S.COMM
HAVING COUNT(O.ONUM) > 1;


# 67. Find all salespeople who have customers with a rating of 300. (Using EXISTS)

SELECT *
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT *
    FROM CUST C
    WHERE C.SNUM = S.SNUM
      AND C.RATING = 300
);


# 68. Find all salespeople who have customers with a rating of 300. (Using JOIN)

SELECT DISTINCT S.*
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
WHERE C.RATING = 300;


# 69. Select all salespeople with customers located in their cities who are not assigned to them. (Using EXISTS)

SELECT *
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT *
    FROM CUST C
    WHERE C.CITY = S.CITY
      AND C.SNUM <> S.SNUM
);


# 70. Extract every customer assigned to a salesperson who currently has at least one other customer with orders.

SELECT *
FROM CUST C
WHERE EXISTS (
    SELECT *
    FROM CUST C2
    JOIN ORDERS O
    ON C2.CNUM = O.CNUM
    WHERE C2.SNUM = C.SNUM
      AND C2.CNUM <> C.CNUM
);


# 71(a). Find salespeople with customers located in their cities. (Using ANY)

SELECT *
FROM SALESPEOPLE
WHERE CITY = ANY (
    SELECT CITY
    FROM CUST
);


# 71(b). Find salespeople with customers located in their cities. (Using IN)

SELECT *
FROM SALESPEOPLE
WHERE CITY IN (
    SELECT CITY
    FROM CUST
);


# 72(a). Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY)

SELECT *
FROM SALESPEOPLE
WHERE SNAME < ANY (
    SELECT CNAME
    FROM CUST
);


# 72(b). Find all salespeople for whom there are customers that follow them in alphabetical order. (Using EXISTS)

SELECT *
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT *
    FROM CUST C
    WHERE C.CNAME > S.SNAME
);


# 73. Select customers who have a greater rating than any customer in Rome.

SELECT *
FROM CUST
WHERE RATING > ANY (
    SELECT RATING
    FROM CUST
    WHERE CITY = 'Rome'
);

# 74. Select all orders that had amounts greater than at least one of the orders from Oct 6th.

SELECT *
FROM ORDERS
WHERE AMT > ANY (
    SELECT AMT
    FROM ORDERS
    WHERE ODATE = '1994-10-06'
);


# 75(a). Find all orders with amounts smaller than any amount for a customer in San Jose. (Using ANY)

SELECT *
FROM ORDERS
WHERE AMT < ANY (
    SELECT AMT
    FROM ORDERS
    WHERE CNUM IN (
        SELECT CNUM
        FROM CUST
        WHERE CITY = 'San Jose'
    )
);


# 75(b). Find all orders with amounts smaller than any amount for a customer in San Jose. (Without ANY)

SELECT *
FROM ORDERS
WHERE AMT < (
    SELECT MAX(AMT)
    FROM ORDERS
    WHERE CNUM IN (
        SELECT CNUM
        FROM CUST
        WHERE CITY = 'San Jose'
    )
);


# 76(a). Select those customers whose ratings are higher than every customer in Paris. (Using ALL)

SELECT *
FROM CUST
WHERE RATING > ALL (
    SELECT RATING
    FROM CUST
    WHERE CITY = 'Paris'
);


# 76(b). Select those customers whose ratings are higher than every customer in Paris. (Using NOT EXISTS)

SELECT *
FROM CUST C1
WHERE NOT EXISTS (
    SELECT *
    FROM CUST C2
    WHERE C2.CITY = 'Paris'
      AND C2.RATING >= C1.RATING
);


# 77. Select all customers whose ratings are equal to or greater than ANY of Serres' customers.

SELECT *
FROM CUST
WHERE RATING >= ANY (
    SELECT RATING
    FROM CUST
    WHERE SNUM = (
        SELECT SNUM
        FROM SALESPEOPLE
        WHERE SNAME = 'Serres'
    )
);


# 78(a). Find all salespeople who have no customers located in their city. (Using ANY)

SELECT *
FROM SALESPEOPLE
WHERE CITY <> ANY (
    SELECT CITY
    FROM CUST
);


# 78(b). Find all salespeople who have no customers located in their city. (Using ALL)

SELECT *
FROM SALESPEOPLE S
WHERE CITY <> ALL (
    SELECT CITY
    FROM CUST C
    WHERE C.SNUM = S.SNUM
);


# 79. Find all orders for amounts greater than any order for customers in London.

SELECT *
FROM ORDERS
WHERE AMT > ANY (
    SELECT AMT
    FROM ORDERS
    WHERE CNUM IN (
        SELECT CNUM
        FROM CUST
        WHERE CITY = 'London'
    )
);


# 80. Find all salespeople and customers located in London.

SELECT S.SNAME, C.CNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C
ON S.CITY = C.CITY
WHERE S.CITY = 'London';


# 81. For every salesperson, dates on which highest and lowest orders were brought.

SELECT
    S.SNAME,
    O.ODATE,
    O.AMT,
    (SELECT MAX(AMT)
     FROM ORDERS O2
     WHERE O2.SNUM = S.SNUM) AS MAX_AMT,
    (SELECT MIN(AMT)
     FROM ORDERS O3
     WHERE O3.SNUM = S.SNUM) AS MIN_AMT
FROM SALESPEOPLE S
JOIN ORDERS O
ON S.SNUM = O.SNUM
WHERE O.AMT = (
        SELECT MAX(AMT)
        FROM ORDERS O2
        WHERE O2.SNUM = S.SNUM
      )
   OR O.AMT = (
        SELECT MIN(AMT)
        FROM ORDERS O3
        WHERE O3.SNUM = S.SNUM
      )
ORDER BY S.SNAME, O.AMT;


# 82. List all of the salespeople and indicate those who don't have customers in their cities as well as those who do have.

SELECT
    S.SNUM,
    S.SNAME,
    S.CITY,
    CASE
        WHEN EXISTS (
            SELECT *
            FROM CUST C
            WHERE C.CITY = S.CITY
        )
        THEN 'Has Customers in City'
        ELSE 'No Customers in City'
    END AS STATUS
FROM SALESPEOPLE S;


# 83. Append strings to the selected fields, indicating whether or not a given salesperson was matched to a customer in his city.

SELECT
    S.SNUM,
    S.SNAME,
    S.CITY,
    CASE
        WHEN EXISTS (
            SELECT *
            FROM CUST C
            WHERE C.SNUM = S.SNUM
              AND C.CITY = S.CITY
        )
        THEN CONCAT(S.SNAME,' is matched to a customer in ',S.CITY)
        ELSE CONCAT(S.SNAME,' is NOT matched to a customer in ',S.CITY)
    END AS STATUS
FROM SALESPEOPLE S;


# 84. Create a UNION of two queries that shows the names, cities and ratings of all customers.
# Customers with rating >= 200 will have 'High Rating'; others 'Low Rating'.

SELECT CNAME,
       CITY,
       RATING,
       'High Rating' AS RATING_STATUS
FROM CUST
WHERE RATING >= 200

UNION

SELECT CNAME,
       CITY,
       RATING,
       'Low Rating' AS RATING_STATUS
FROM CUST
WHERE RATING < 200;


# 85. Write command that produces the name and number of each salesperson and each customer with more than one current order.
# Put the result in alphabetical order.

SELECT
    S.SNAME,
    C.CNAME,
    C.CNUM
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
JOIN ORDERS O
ON C.CNUM = O.CNUM
GROUP BY S.SNAME, C.CNAME, C.CNUM
HAVING COUNT(O.ONUM) > 1
ORDER BY C.CNAME;


# 86. Form a union of three queries.
# First: SNUMs of salespeople in San Jose.
# Second: CNUMs of customers in San Jose.
# Third: ONUMs of orders on Oct. 3.

SELECT SNUM AS NUMBER
FROM SALESPEOPLE
WHERE CITY = 'San Jose'

UNION

SELECT CNUM
FROM CUST
WHERE CITY = 'San Jose'

UNION ALL

SELECT ONUM
FROM ORDERS
WHERE ODATE = '1994-10-03';


# 87. Produce all the salespeople in London who had at least one customer there.

SELECT DISTINCT S.*
FROM SALESPEOPLE S
JOIN CUST C
ON S.SNUM = C.SNUM
WHERE S.CITY = 'London'
  AND C.CITY = 'London';


# 88. Produce all the salespeople in London who did not have customers there.

SELECT *
FROM SALESPEOPLE S
WHERE S.CITY = 'London'
AND NOT EXISTS (
    SELECT *
    FROM CUST C
    WHERE C.SNUM = S.SNUM
      AND C.CITY = 'London'
);


# 89. We want to see salespeople matched to their customers without excluding those salespeople who were not currently assigned to any customers.

SELECT
    S.SNUM,
    S.SNAME,
    S.CITY,
    C.CNUM,
    C.CNAME
FROM SALESPEOPLE S
LEFT OUTER JOIN CUST C
ON S.SNUM = C.SNUM;