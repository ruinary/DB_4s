use Control;

--1
select Distinct PRODUCTS.PRODUCT_ID, PRODUCTS.DESCRIPTION, OFFICES.REGION
from ORDERS 
inner join SALESREPS On SALESREPS.EMPL_NUM = ORDERS.REP
--inner join OFFICES On OFFICES.MGR = ORDERS.REP
inner join OFFICES On SALESREPS.REP_OFFICE = OFFICES.OFFICE
inner join PRODUCTS On ORDERS.PRODUCT 
= PRODUCTS.PRODUCT_ID
where REGION  not Like 'Western'

--2
select Top (3) PRODUCT_ID [ID товара], SUM(ORDERS.QTY) [Количество заказов]
from PRODUCTS
inner join ORDERS On PRODUCTS.PRODUCT_ID = ORDERS.PRODUCT
group by PRODUCT_ID
order by 'Количество заказов' asc