SELECT dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem, SUM(hdct.so_luong) AS tong_so_luong
FROM dich_vu_di_kem dvdk
JOIN hop_dong_chi_tiet hdct ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
GROUP BY dvdk.ma_dich_vu_di_kem
HAVING tong_so_luong = (
    SELECT SUM(so_luong) FROM hop_dong_chi_tiet 
    GROUP BY ma_dich_vu_di_kem ORDER BY SUM(so_luong) DESC LIMIT 1
);