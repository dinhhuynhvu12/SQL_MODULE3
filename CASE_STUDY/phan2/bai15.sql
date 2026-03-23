SELECT nv.MANHANVIEN,nv.ho_ten,td.ten_trinh_do,bp.ten_bo_phan,nv.SO_DT,nv.dia_chi
FROM nhan_vien nv
JOIN trinh_do td ON nv.ma_trinh_do = td.ma_trinh_do
JOIN bo_phan bp ON nv.ma_bo_phan = bp.ma_bo_phan
JOIN hop_dong hd ON nv.MANHANVIEN = hd.MANHANVIEN
WHERE YEAR(hd.ngay_lam_hop_dong) BETWEEN 2020 AND 2021
GROUP BY nv.MANHANVIEN,nv.ho_ten,td.ten_trinh_do,bp.ten_bo_phan,nv.SO_DT,nv.dia_chi
HAVING COUNT(hd.ma_hop_dong) <= 3;