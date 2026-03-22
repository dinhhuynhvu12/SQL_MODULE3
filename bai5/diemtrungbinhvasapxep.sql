SELECT S.StudentId, S.StudentName , AVG(ma.Mark) AS AverageMark
    from student s
    join mark ma on s.StudentID = ma.StudentID
    group by s.StudentID,s.StudentName
    order by AverageMark desc;
