UPDATE dich_vu_di_kem 
SET gia = gia * 2
WHERE ma_dich_vu_di_kem IN (
    SELECT ma_dich_vu_di_kem FROM hop_dong_chi_tiet hdct
    JOIN hop_dong hd ON hdct.ma_hop_dong = hd.ma_hop_dong
    WHERE YEAR(hd.ngay_lam_hop_dong) = 2020
    GROUP BY ma_dich_vu_di_kem
    HAVING SUM(so_luong) > 10
);