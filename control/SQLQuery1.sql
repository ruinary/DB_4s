use Control;
--1
select Top (3) PRODUCT_ID [ID товара], SUM(ORDERS.AMOUNT) [Количество]
from PRODUCTS
Inner Join ORDERS On PRODUCTS.PRODUCT_ID = ORDERS.PRODUCT
Group by PRODUCT_ID
Order by 'Количество' desc

--2
select OFFICE [Офис], SALES [Количество], CITY [Город]
from OFFICES
Order by CITY asc