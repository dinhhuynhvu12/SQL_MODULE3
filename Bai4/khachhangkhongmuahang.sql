select c.name as customer 
from customer c
left join order_table ta on c.cID = ta.cID
where  ta.oID is null;