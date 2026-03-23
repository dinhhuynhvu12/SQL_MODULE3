select dvdk.* from dich_vu_di_kem dvdk
 join hop_dong_chi_tiet hdct on dvdk.MA_DICH_VU_DI_KEM = hdct.MA_DICH_VU_DI_KEM
 join hop_dong hd on hdct.MA_HOP_DONG = hd.MA_HOP_DONG
 join khach_hang kh on hd.MA_KHACH_HANG = kh.MA_KHACH_HANG
 join loai_khach lkh on kh.MA_LOAI_KHACH = lkh.MA_LOAI_KHACH
where lkh.TEN_LOAI_KHACH = "Diamond" and (kh.DIA_CHI like "%Vinh%" or kh.DIA_CHI like "%Quảng Ngãi%");