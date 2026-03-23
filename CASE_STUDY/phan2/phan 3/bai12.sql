select hd.ma_hop_dong ,nv.ho_ten ,kh.ho_ten,kh.so_dien_thoai,dv.ten_dich_vu,sum(ifnull( hdct.so_luong,0)) as soluongtong,hd.tien_dat_coc
from hop_dong hd
join nhan_vien	nv on hd.MANHANVIEN = nv.MANHANVIEN
join khach_hang kh on hd.MA_KHACH_HANG = kh.MA_KHACH_HANG
join dich_vu dv on hd.MA_DICH_VU = dv.MA_DICH_VU
left join hop_dong_chi_tiet hdct on hd.MA_HOP_DONG = hdct.MA_HOP_DONG
where (month(hd.ngay_lam_hop_dong) between 10 and 12 and year(hd.ngay_lam_hop_dong) = 2020) and
hd.ma_dich_vu NOT IN(
select MA_DICH_VU from hop_dong WHERE (MONTH(ngay_lam_hop_dong) BETWEEN 1 AND 6 AND YEAR(ngay_lam_hop_dong) = 2021)
)
GROUP BY hd.ma_hop_dong;
