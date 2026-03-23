select kh.ma_khach_hang ,kh.HO_TEN, count(ma_hop_dong) as solandatphong
from khach_hang kh
join loai_khach lk on kh.MA_LOAI_KHACH = lk.MA_LOAI_KHACH
left join hop_dong hd on kh.MA_KHACH_HANG = hd.MA_KHACH_HANG
where TEN_LOAI_KHACH = "Diamond"
group by kh.ma_khach_hang 
order by solandatphong asc;
