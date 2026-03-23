DELETE FROM khach_hang 
WHERE ma_khach_hang IN (SELECT ma_khach_hang FROM hop_dong WHERE YEAR(ngay_lam_hop_dong) < 2021);