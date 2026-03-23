select kh.ma_khach_hang, kh.ho_ten ,lk.ten_loai_khach,hd.ma_hop_dong,dv.ten_dich_vu,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc ,
sum(ifnull(dv.chi_phi_thue,0) + ifnull(hdct.so_luong,0) * ifnull(dvdk.gia,0)) as tong_tien 
from khach_hang kh
left join loai_khach lk on kh.MA_LOAI_KHACH = lk.MA_LOAI_KHACH
left join hop_dong hd on kh.MA_KHACH_HANG  = hd.MA_KHACH_HANG
left join dich_vu dv on hd.MA_DICH_VU = dv.MA_DICH_VU
left join hop_dong_chi_tiet hdct on hd.MA_HOP_DONG = hdct.MA_HOP_DONG
left join dich_vu_di_kem dvdk on hdct.MA_DICH_VU_DI_KEM = dvdk.MA_DICH_VU_DI_KEM
group by kh.ma_khach_hang,hd.ma_hop_dong;