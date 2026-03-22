select S.StudentName, sub.SubName , ma.Mark
from mark ma
join student S on ma.StudentID = S.StudentID
join Subject sub on ma.SubID = sub.SubID
order by ma.Mark desc, S.StudentName asc;