SELECT MANHANVIEN AS id, ho_ten, email, SO_DT, ngay_sinh, dia_chi FROM nhan_vien
UNION ALL
SELECT ma_khach_hang AS id, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi FROM khach_hang;