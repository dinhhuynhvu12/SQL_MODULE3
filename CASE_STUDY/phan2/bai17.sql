UPDATE khach_hang 
SET ma_loai_khach = (SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Diamond')
WHERE ma_loai_khach = (SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Platinum')
AND ma_khach_hang IN (

    SELECT hd.ma_khach_hang FROM hop_dong hd
    JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
    JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
    JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    WHERE YEAR(hd.ngay_lam_hop_dong) = 2021
    GROUP BY hd.ma_khach_hang
    HAVING SUM(dv.chi_phi_thue + hdct.so_luong * dvdk.gia) > 10000000
);