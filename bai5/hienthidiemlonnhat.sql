SELECT  sub.subID ,sub.SubName as subject,ma.mark as Mark
from mark ma
join subject sub on ma.SubID = sub.SubID
order by mark desc
limit 1; 