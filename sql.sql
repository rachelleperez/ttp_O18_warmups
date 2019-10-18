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

-- Goal - more customers to store. Let's make a promo on the PG-13 movies! 
-- Assignment - generate new prices based on constraints
 --   If movie PG-13 and rent price <= $1 THEN new price 0.10. 
 --   if movie PG-13 and rent price is > 1 AND <= 2 THEN new price 1
 --   else movie PG 13 new price = rent price (current)


*** QUERY ***

-- Assignment Output: Updated Price list for PG-13 movies >> film_id, title, current_rental_rate, new_price

WITH pg13_films AS (
    SELECT film_id, title, rental_rate
    FROM FILM
    WHERE rating = 'PG-13'
)

SELECT 
    film_id, 
    title,
    rental_rate AS current_rental_rate, 
    CASE 
        WHEN (rental_rate <= 1) THEN 0.10
        WHEN (rental_rate >1 AND rental_rate <= 2) THEN 1
        ELSE rental_rate
        END AS promo_rental_rate
FROM pg13_films
ORDER BY film_id;


*** ALTERNATIVE *** (ALL MOVIES WITH NEW PRICES, CHANGE ONLY ON PG-13 rental_price <2)

-- Assigment Output: Updated price list for all films during promo time

** VERSION 1**

SELECT 
    film_id, 
    title,
    rating,
    rental_rate AS current_rental_rate, 
    CASE
            WHEN (rating = 'PG-13' AND rental_rate <= 1) THEN 0.10
            WHEN (rating = 'PG-13' AND rental_rate >1 AND rental_rate <= 2) THEN 1
            ELSE rental_rate
            END AS promo_rental_rate
FROM film
ORDER BY film_id;


** VERSION 2 **

WITH pg13_films AS (
    SELECT film_id, title, rental_rate
    FROM FILM
    WHERE rating = 'PG-13'
)

SELECT 
    film_id, 
    title,
    rental_rate AS current_rental_rate, 
    CASE 
        WHEN (film_id IN (SELECT film_id FROM pg13_films) AND f.rental_rate <1) THEN 0.10
        WHEN (film_id IN (SELECT film_id FROM pg13_films) AND f.rental_rate >1 AND f.rental_rate <= 2) THEN 1
        ELSE f.rental_rate
        END AS promo_rental_rate
FROM film f
ORDER BY film_id;

** VERSION 3 **

WITH pg13_films AS (
    SELECT film_id, title, rental_rate
    FROM FILM
    WHERE rating = 'PG-13'
)

SELECT 
    film_id, 
    title,
    rental_rate AS current_rental_rate, 
    CASE 
        WHEN (film_id IN (SELECT film_id FROM pg13_films))
        THEN
            CASE
                WHEN (rating = 'PG-13' AND rental_rate <= 1) THEN 0.10
                WHEN (rating = 'PG-13' AND rental_rate >1 AND rental_rate <= 2) THEN 1
                ELSE rental_rate
                END
        ELSE rental_rate
        END AS promo_rental_rate
FROM film f
ORDER BY film_id;
