-- CASE WHEN - the if/else statements of SQL! It's litterally the same as if/else that we've seen in python
-- and excel, but different syntax:
-- CASE
-- WHEN (condition) THEN <output>
-- WHEN (condition) THEN <output>
-- ELSE <output>
-- END as <alias>

-- EXAMPLE:
--  SELECT 
-- 	name,
--   	CASE 
--      WHEN (monthlymaintenance > 100) THEN 'expensive'
--  	ELSE 'cheap'
--  	END AS cost <<-- this whole thing outputs a column ('cost') with output ('expensive','cheap')
-- 						depending on the condition being met in each row
--  FROM ...

-- YOUR TURN!
-- Our marketing analytics team has decided to do a promotion to get more customers to come into our store.
-- They've decided that they want all of the cheapest PG-13 films to now be rented at $0.10, 
-- and all PG-13 films in the NEXT HIGHER rental bracket above one dollar to now by rented at $1.00.
-- Return a list of all PG-13 films with the current and new rental rates - with films in the cheapest
-- rental bracket discounted to $0.10, and films in the rental bracket next above a dollar now being $1**. 

-- **To clarify - if the rental brackets were 0.99, 1.99, 2.99, 3.99, we want the new prices to be
-- 0.10, 1.00, 2.99, 3.99

-- HINT: you can hardcode the rental bracket rates (just typing in the number - eg 1.99) first to make sure 
-- you can get your CASE WHEN statement to work, THEN see if you can put it all together with softcoding 
-- (using a CTE/subquery to return the number - eg. 1.99)

-- CHECK OUT THE HINTS FILE IF YOU GET STUCK

*** NOTES***

-- Goal - most customers to store. Let's make a promo! 
-- Assignment - generate new prices based on constraints
 --   If movie PG-13 and rent price <= $1 THEN new price 0.10. 
 --   if movie PG-13 and rent price is > 1 AND <= 2 THEN new price 1
 --   else movie PG 13 new price = rent price (current)

--Assignment Output: film_id, title, current_rental_rate, new_price


*** QUERY ***

WITH pg13_films AS (
    SELECT film_id, title, rental_rate
    FROM FILM
    WHERE rating = 'PG-13'
)

SELECT 
    film_id, 
    rental_rate AS current_rental_rate, 
    CASE 
        WHEN (rental_rate <= 1) THEN 0.10
        WHEN (rental_rate >1 AND rental_rate <= 2) THEN 1
        ELSE rental_rate
        END AS promo_rental_rate
FROM pg13_films
ORDER BY film_id;

**** ANSWER (FIRST ROWS ONLY!) ***

film_id | current_rental_rate | promo_rental_rate
---------+---------------------+-------------------
       7 |                4.99 |              4.99
       9 |                2.99 |              2.99
      18 |                0.99 |              0.10
      28 |                4.99 |              4.99
      33 |                2.99 |              2.99
      35 |                2.99 |              2.99
      36 |                0.99 |              0.10
      44 |                4.99 |              4.99
      45 |                4.99 |              4.99
      48 |                4.99 |              4.99
      57 |                2.99 |              2.99
      64 |                0.99 |              0.10
      67 |                2.99 |              2.99
      71 |                4.99 |              4.99
      73 |                2.99 |              2.99
      79 |                0.99 |              0.10
      81 |                4.99 |              4.99
      94 |                2.99 |              2.99
      96 |                2.99 |              2.99
      98 |                4.99 |              4.99
     108 |                0.99 |              0.10
     124 |                4.99 |              4.99
     130 |                0.99 |              0.10
     141 |                4.99 |              4.99
     152 |                2.99 |              2.99
     155 |                0.99 |              0.10
     157 |                0.99 |              0.10

