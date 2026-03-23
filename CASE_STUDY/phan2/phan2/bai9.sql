select month(ngay_lam_hop_dong) as thang ,count(ma_khach_hang) as soluong
from hop_dong
where year(ngay_lam_hop_dong) = 2021
group by thang
order by thang