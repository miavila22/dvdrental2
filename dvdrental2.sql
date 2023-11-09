-- 1. List all customers who live in Texas (use JOINs). Answer: 5 people live in Texas.
SELECT first_name, last_name, customer_id, address.address_id
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
INNER JOIN city 
ON address.city_id = city.city_id
WHERE district = 'Texas'


-- 2. Get all payments above $6.99 with the Customer's Full Name. Answer: 1406 payments
SELECT first_name, last_name, amount, customer.customer_id
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id 
WHERE amount > 6.99;



-- 3. Show all customers names who have made payments over $175(use subqueries) Answer: 6 customers
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


-- 4. List all customers that live in Nepal (use the city table). Answer: 1 customer
SELECT first_name, last_name, customer.address_id, country.country
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country = 'Nepal';


-- 5. Which staff member had the most transactions? Answer: Jon Stephens with 7304 transactions
SELECT COUNT(payment.payment_id), first_name, last_name, staff.staff_id
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
INNER JOIN rental 
ON payment.rental_id = rental.rental_id
GROUP BY staff.staff_id, first_name, last_name
ORDER BY staff.staff_id DESC
LIMIT 1;




-- 6. How many movies of each rating are there? Answer: G: 178, PG: 194, PG-13: 223, R: 195, NC-17:210
SELECT COUNT(rating), rating
FROM film
GROUP BY rating;


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries) Answer: 130 customers made a single payment over $6.99

-- SELECT customer.customer_id, first_name, last_name
-- FROM customer
-- INNER JOIN payment ON customer.customer_id = payment.customer_id
-- WHERE payment.amount > 6.99
-- GROUP BY customer.customer_id, first_name, last_name
-- HAVING COUNT(payment.payment_id) = 1 AND COUNT(DISTINCT payment.amount) = 1;


SELECT DISTINCT(customer.customer_id), first_name, last_name
FROM customer 
WHERE customer_id IN( 
	SELECT customer_id
	FROM payment 
	WHERE payment.amount > 6.99
	GROUP BY customer_id 
	HAVING COUNT(payment.amount) = 1
);

-- 8. How many rentals did our store give away? Answer: 24 free rentals
SELECT COUNT(rental)
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0;



