use sakila
--1a
select a.first_name,a.last_name

from actor a 
--1b
select a.first_name,a.last_name,
	concat(a.first_name, a.last_name) as Actor_Name
from actor a

--2a 
select a.first_name,a.actor_id,a.last_name
from actor a
where a.first_name = "Joe"

--2b
select a.first_name,a.actor_id,a.last_name
from actor a
where a.last_name LIKE '%GEN%'

--2c
select a.first_name,a.actor_id,a.last_name
from actor a
where a.last_name LIKE '%LI%'
group by 1,2,3
order by 1,3

--2d
select c.country_id, c.country
from country c
where c.country IN ('Afghanistan', 'Bangladesh','China')

--3a
alter table actor
add column description blob 

--3b
alter table actor
drop column description
--4a
select a.last_name, count(*)

from actor a
group by 1
order by 2 DESC

--4b
select a.last_name, count(*) as nbr_act
from actor a
group by 1
HAVING COUNT(*) > 1
order by 2

--4c
update actor 
set first_name = 'HARPO'
where last_name = 'WILLIAMS' and first_name ='GROUCHO'

--4d
update actor 
set first_name = 'GROUCHO'
where last_name = 'WILLIAMS' and first_name ='HARPO'

-- select* from actor a
-- where a.first_name = 'GROUCHO'

--5a
show create table actor

--6a

select s.first_name, s.last_name,ad.address 
from staff s 
	left join address ad on ad.address_id = s.address_id
group by 1,2,3

--6b
select s.first_name, s.last_name, sum(p.amount) as total_amount
from staff s 
left join payment p on p.staff_id = s.staff_id
where YEAR(p.payment_date) = '2005' and MONTH(p.payment_date)='08'
group by 1,2
order by 3

--6c
select f.title, count(fa.actor_id) as nbr_actors
from film f
left join film_actor fa on fa.film_id = f.film_id
group by 1
order by 2 desc

--6d
select f.title, count(i.film_id)
from film f
left join inventory i on i.film_id = f.film_id
where f.title = 'Hunchback Impossible'
group by 1
order by 2

--6e
select c.first_name, min(c.last_name), sum(p.amount)
from customer c 
left join payment p on p.customer_id = c.customer_id
group by 1
order by 2

--7a
select f.title ,f.language_id
from film f
where f.title like 'K%' OR f.title like 'Q%' and
f.language_id = (
select l.language_id
from language l
where l.name = 'English'
)



--7b
select a.first_name, a.last_name
from actor a
where a.actor_id in

( select fa.actor_id from film_actor fa  where fa.film_id = 
 (select f.film_id
from film f
where f.title = 'Alone Trip'
)
)



--7c
select c.first_name,c.last_name, c.email
from customer c 
left join address ad on ad.address_id = c.address_id
left join city cy on cy.city_id = ad.city_id
left join country cot on cot.country_id = cy.country_id
where cot.country = 'Canada'



--7d
select f.title
from film f
left join film_category fc on fc.film_id = f.film_id
left join category cat on cat.category_id = fc.category_id
where cat.name = 'Family'


--7e
select f.title,count(f.film_id) as nbr_rented 
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
group by 1
order by 2 desc


--7f
select s.store_id, sum(p.amount)
from store s
left join staff sf on sf.store_id = s.store_id
left join payment p on p.staff_id = sf.staff_id
group by 1
order by 2

--7g
select s.store_id,c.city,cty.country
from store s
left join address ad on ad.address_id = s.address_id 
left join city c on c.city_id = ad.city_id
left join country cty on cty.country_id = c.country_id

--7h

select c.name as top_five, sum(p.amount) as total_gross_profit
from category c

left join film_category fc on fc.category_id = c.category_id
left join inventory i on i.film_id= fc.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id
group by 1
order by 2 desc limit 5


--8a

CREATE VIEW 'top_five_genres'AS
select c.name as top_five, sum(p.amount) as total_gross_profit
from category c

left join film_category fc on fc.category_id = c.category_id
left join inventory i on i.film_id= fc.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id
group by 1
order by 2  desc limit 5

--8b
select * from top_five_genres 

--8c
Drop view top_five_genres 







