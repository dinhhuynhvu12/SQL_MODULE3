SELECT * FROM khach_hang
where (timestampdiff(YEAR ,NGAY_SINH,CURDATE() ) BETWEEN 18 AND 50)
AND (DIA_CHI LIKE '%Đà Nẵng%' or '%Quảng Trị%');