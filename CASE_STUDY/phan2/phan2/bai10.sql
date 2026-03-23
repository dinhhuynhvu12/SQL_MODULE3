select hd.ma_hop_dong,hd.ngay_lam_hop_dong,hd.ngay_ket_thuc, hd.tien_dat_coc,sum(ifnull(hdct.so_luong ,0)) as so_luong_dich_vu_di_kem 
from hop_dong hd
left join  hop_dong_chi_tiet hdct on hd.MA_HOP_DONG = hdct.MA_HOP_DONG
group by hd.ma_hop_dong