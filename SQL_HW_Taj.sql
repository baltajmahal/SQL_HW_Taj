use sakila;

#1a
select first_name, last_name
from actor;


#1b
select concat(first_name," ", last_name)
from actor;

#2a
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

#2b
select *
from actor
where last_name like '%GEN%';

#2c
select last_name, First_name
from actor
where last_name like '%LI%'
order by last_name and first_name asc;


#2d
select country_id , country
from country
where country in ('Afghanistan','Bangladesh','China');


#3a
Alter table actor
add column description varchar(100);



#3b
Alter table actor
drop column description ;


#4a
select last_name, count(last_name)
from actor
group by last_name;

#4b
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) >=2;


#4c
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' ;
SET SQL_SAFE_UPDATES = 1;


#4d

SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;
SET SQL_SAFE_UPDATES = 1;

#5a

Create table address (
 address_id INT AUTO_INCREMENT NOT NULL,
  adress VARCHAR(100),
  address2 VARCHAR(100),
  PRIMARY KEY (address_id))


#6a

use sakila;
SELECT *
from staff s
join address a
on s.address_id = a.address_id;

#6b
use sakila;
SELECT sum(amount) as Total_Amount, s.staff_id, s.first_name, s.last_name, p.payment_date
from payment p
join staff s
on p.staff_id = s.staff_id
where year(p.payment_date) = 2005 and month(p.payment_date) = 8
group by s.staff_id;


#6c
use sakila;
select f.film_id, f.title, f.release_year, count(a.actor_id)
from film f
join film_actor a
on f.film_id = a.film_id
group by f.film_id;

#6d
use sakila;
select i.film_id, f.title, count(i.inventory_id) as Number_of_Copies
from inventory i
join film f
on i.film_id = f.film_id
where title  = 'Hunchback Impossible';


#6e
use sakila;
select  c.last_name , c.first_name, c.customer_id,  sum(p.amount) as Total_Payment
from payment p
join customer c
on p.customer_id = c.customer_id
group by c.customer_id
order by c.last_name asc;

#7a
select *
from film
where language_id in (select language_id
					  from language
					  where name = 'english') 
                      and title in 
                      (select title
					   from film
                       where title like 'k%' or title like 'Q%');
                       
#7b

select *
from actor
where actor_id in (select actor_id
from film_actor
where film_id in (select film_id
from film
where title = 'Alone Trip'));


#7c
use sakila;
select c.first_name, c.last_name, c.email, n.country
from customer c
join address a
on c.address_id = a.address_id
join city i
on a.city_id = i.city_id
join country n
on i.country_id = n.country_id
where n.country = 'Canada';


#7d
use sakila;
select *
from film
where rating in ('PG','PG-13','G','NC-17');


#7e

select f.title, count(*)
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on r.inventory_id = i.inventory_id
group by f.title
order by count(*) desc, f.title;

#7f
select o.store_id , sum(p.amount) as Amount
from rental r
join payment p
on r.rental_id = p.rental_id
join staff s
on p.staff_id = s.staff_id
join store o
on s.store_id = o.store_id
group by o.store_id;

#7g




#7h
use sakila;
select c.name, sum(p.amount) as Gross_Amount
from category c
join film_category f
on c.category_id = f.category_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by 2 desc
limit 5;

#8a
create or replace view executive as 
select c.name, sum(p.amount) as Gross_Amount
from category c
join film_category f
on c.category_id = f.category_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by 2 desc
limit 5;

#8b
select *
from executive;

#8c
drop view executive;