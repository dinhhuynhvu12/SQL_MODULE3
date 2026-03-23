use quanlikhachsan;
SELECT * FROM nhan_vien 
WHERE (ho_ten LIKE 'H%' OR ho_ten LIKE 'T%' OR ho_ten LIKE 'K%') 
AND LENGTH(ho_ten) <= 15; 
