use Control;
--1
select Top (3) PRODUCT_ID [ID ������], SUM(ORDERS.AMOUNT) [����������]
from PRODUCTS
Inner Join ORDERS On PRODUCTS.PRODUCT_ID = ORDERS.PRODUCT
Group by PRODUCT_ID
Order by '����������' desc

--2
select OFFICE [����], SALES [����������], CITY [�����]
from OFFICES
Order by CITY asc