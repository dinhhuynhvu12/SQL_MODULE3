select dv.ma_dich_vu,dv.ten_dich_vu,dv.dien_tich,dv.so_nguoi_toi_da,dv.chi_phi_thue,ldv.ten_loai_dich_vu 
from dich_vu dv
join loai_dich_vu ldv on dv.MA_LOAI_DICH_VU = ldv.MA_LOAI_DICH_VU
where dv.ma_dich_vu  in(
select MA_DICH_VU from hop_dong
where ( year(ngay_lam_hop_dong) = 2020)
)
and dv.ma_dich_vu not in(
select MA_DICH_VU from hop_dong
where ( year(ngay_lam_hop_dong) = 2021)
)