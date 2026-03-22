select m.Name as CustomerName , du.pName as Product
from customer m
join order_table ta on m.cID = ta.cID
join orderdetail de on ta.oID = de.oID
join product du on de.pID = du.pID;