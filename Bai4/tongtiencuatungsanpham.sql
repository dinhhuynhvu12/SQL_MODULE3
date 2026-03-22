select o.oID, o.oDate as order_table, SUM(od.odQTY * p.pPrice) TotalPrice 
from order_table o
join orderdetail od on o.oID = od.oID
join product p on od.pID = p.pID
group by o.oID, o.oDate;