-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: quanlikhachsan
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bo_phan`
--

DROP TABLE IF EXISTS `bo_phan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bo_phan` (
  `MA_BO_PHAN` int NOT NULL AUTO_INCREMENT,
  `TEN_BO_PHAN` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_BO_PHAN`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bo_phan`
--

LOCK TABLES `bo_phan` WRITE;
/*!40000 ALTER TABLE `bo_phan` DISABLE KEYS */;
INSERT INTO `bo_phan` VALUES (1,'Sale-Marketing'),(2,'Hành chính'),(3,'Phục vụ'),(4,'Quản lý');
/*!40000 ALTER TABLE `bo_phan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dich_vu`
--

DROP TABLE IF EXISTS `dich_vu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dich_vu` (
  `MA_DICH_VU` int NOT NULL AUTO_INCREMENT,
  `TEN_DICH_VU` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DIEN_TICH` int DEFAULT NULL,
  `CHI_PHI_THUE` float DEFAULT NULL,
  `SO_NGUOI_TOI_DA` int DEFAULT NULL,
  `MA_KIEU_THUE` int DEFAULT NULL,
  `MA_LOAI_DICH_VU` int DEFAULT NULL,
  `TIEU_CHUAN_PHONG` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `MO_TA_TIEN_NGHI_KHAC` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DIEN_TICH_HO_BOI` float DEFAULT NULL,
  `SO_TANG` int DEFAULT NULL,
  PRIMARY KEY (`MA_DICH_VU`),
  KEY `MA_KIEU_THUE` (`MA_KIEU_THUE`),
  KEY `MA_LOAI_DICH_VU` (`MA_LOAI_DICH_VU`),
  CONSTRAINT `dich_vu_ibfk_1` FOREIGN KEY (`MA_KIEU_THUE`) REFERENCES `kieu_thue` (`MA_KIEU_THUE`),
  CONSTRAINT `dich_vu_ibfk_2` FOREIGN KEY (`MA_LOAI_DICH_VU`) REFERENCES `loai_dich_vu` (`MA_LOAI_DICH_VU`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dich_vu`
--

LOCK TABLES `dich_vu` WRITE;
/*!40000 ALTER TABLE `dich_vu` DISABLE KEYS */;
INSERT INTO `dich_vu` VALUES (1,'Villa Beach Front',25000,10000000,10,3,1,'vip','Có hồ bơi',500,4),(2,'House Princess 01',14000,5000000,7,2,2,'vip','Có thêm bếp nướng',NULL,3),(3,'Room Town House',5000,1000000,2,4,3,'normal','Có tivi',NULL,NULL),(4,'Villa No Beach Front',22000,9000000,8,3,1,'normal','Có hồ bơi',300,3),(5,'House Princess 02',10000,4000000,5,3,2,'normal','Có thêm bếp nướng',NULL,2),(6,'Room Town House 02',3000,900000,2,4,3,'normal','Có tivi',NULL,NULL);
/*!40000 ALTER TABLE `dich_vu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dich_vu_di_kem`
--

DROP TABLE IF EXISTS `dich_vu_di_kem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dich_vu_di_kem` (
  `MA_DICH_VU_DI_KEM` int NOT NULL AUTO_INCREMENT,
  `TEN_DICH_VU_DI_KEM` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `GIA` float DEFAULT NULL,
  `DON_VI` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TRANG_THAI` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_DICH_VU_DI_KEM`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dich_vu_di_kem`
--

LOCK TABLES `dich_vu_di_kem` WRITE;
/*!40000 ALTER TABLE `dich_vu_di_kem` DISABLE KEYS */;
INSERT INTO `dich_vu_di_kem` VALUES (1,'Karaoke',10000,'giờ','tiện nghi hiện đại'),(2,'Thuê xe máy',10000,'chiếc','hỏng 1 xe'),(3,'Thuê xe đạp',20000,'chiếc','tốt'),(4,'Buffet sáng',15000,'suất','đầy đủ đồ ăn, tráng miệng'),(5,'Buffet trưa',90000,'suất','đầy đủ đồ ăn, tráng miệng'),(6,'Buffet tối',16000,'suất','đầy đủ đồ ăn, tráng miệng');
/*!40000 ALTER TABLE `dich_vu_di_kem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hop_dong`
--

DROP TABLE IF EXISTS `hop_dong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hop_dong` (
  `MA_HOP_DONG` int NOT NULL AUTO_INCREMENT,
  `NGAY_LAM_HOP_DONG` datetime DEFAULT NULL,
  `NGAY_KET_THUC` datetime DEFAULT NULL,
  `TIEN_DAT_COC` float DEFAULT NULL,
  `MANHANVIEN` int DEFAULT NULL,
  `MA_KHACH_HANG` int DEFAULT NULL,
  `MA_DICH_VU` int DEFAULT NULL,
  PRIMARY KEY (`MA_HOP_DONG`),
  KEY `MANHANVIEN` (`MANHANVIEN`),
  KEY `MA_KHACH_HANG` (`MA_KHACH_HANG`),
  KEY `MA_DICH_VU` (`MA_DICH_VU`),
  CONSTRAINT `hop_dong_ibfk_1` FOREIGN KEY (`MANHANVIEN`) REFERENCES `nhan_vien` (`MANHANVIEN`),
  CONSTRAINT `hop_dong_ibfk_2` FOREIGN KEY (`MA_KHACH_HANG`) REFERENCES `khach_hang` (`MA_KHACH_HANG`),
  CONSTRAINT `hop_dong_ibfk_3` FOREIGN KEY (`MA_DICH_VU`) REFERENCES `dich_vu` (`MA_DICH_VU`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hop_dong`
--

LOCK TABLES `hop_dong` WRITE;
/*!40000 ALTER TABLE `hop_dong` DISABLE KEYS */;
INSERT INTO `hop_dong` VALUES (1,'2020-12-08 00:00:00','2020-12-08 00:00:00',0,3,1,3),(2,'2020-07-14 00:00:00','2020-07-21 00:00:00',200000,7,3,1),(3,'2021-03-15 00:00:00','2021-03-17 00:00:00',50000,3,4,2),(4,'2021-01-14 00:00:00','2021-01-18 00:00:00',100000,7,5,5),(5,'2021-07-14 00:00:00','2021-07-15 00:00:00',0,7,2,6),(6,'2021-06-01 00:00:00','2021-06-03 00:00:00',0,7,7,6),(7,'2021-09-02 00:00:00','2021-09-05 00:00:00',100000,7,4,4),(8,'2021-06-17 00:00:00','2021-06-18 00:00:00',150000,3,4,1),(9,'2020-11-19 00:00:00','2020-11-19 00:00:00',0,3,4,3),(10,'2021-04-12 00:00:00','2021-04-14 00:00:00',0,10,3,5),(11,'2021-04-25 00:00:00','2021-04-25 00:00:00',0,2,2,1),(12,'2021-05-25 00:00:00','2021-05-27 00:00:00',0,7,10,1);
/*!40000 ALTER TABLE `hop_dong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hop_dong_chi_tiet`
--

DROP TABLE IF EXISTS `hop_dong_chi_tiet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hop_dong_chi_tiet` (
  `MA_HOP_DONG_CHI_TIET` int NOT NULL AUTO_INCREMENT,
  `MA_HOP_DONG` int DEFAULT NULL,
  `MA_DICH_VU_DI_KEM` int DEFAULT NULL,
  `SO_LUONG` int DEFAULT NULL,
  PRIMARY KEY (`MA_HOP_DONG_CHI_TIET`),
  KEY `MA_HOP_DONG` (`MA_HOP_DONG`),
  KEY `MA_DICH_VU_DI_KEM` (`MA_DICH_VU_DI_KEM`),
  CONSTRAINT `hop_dong_chi_tiet_ibfk_1` FOREIGN KEY (`MA_HOP_DONG`) REFERENCES `hop_dong` (`MA_HOP_DONG`),
  CONSTRAINT `hop_dong_chi_tiet_ibfk_2` FOREIGN KEY (`MA_DICH_VU_DI_KEM`) REFERENCES `dich_vu_di_kem` (`MA_DICH_VU_DI_KEM`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hop_dong_chi_tiet`
--

LOCK TABLES `hop_dong_chi_tiet` WRITE;
/*!40000 ALTER TABLE `hop_dong_chi_tiet` DISABLE KEYS */;
INSERT INTO `hop_dong_chi_tiet` VALUES (1,2,4,5),(2,2,5,8),(3,2,6,15),(4,3,1,1),(5,3,2,11),(6,1,3,1),(7,1,2,2),(8,12,2,2);
/*!40000 ALTER TABLE `hop_dong_chi_tiet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khach_hang`
--

DROP TABLE IF EXISTS `khach_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khach_hang` (
  `MA_KHACH_HANG` int NOT NULL AUTO_INCREMENT,
  `MA_LOAI_KHACH` int DEFAULT NULL,
  `HO_TEN` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NGAY_SINH` date DEFAULT NULL,
  `GIOITINH` bit(1) DEFAULT NULL,
  `SO_CMND` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SO_DIEN_THOAI` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `EMAIL` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DIA_CHI` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_KHACH_HANG`),
  KEY `MA_LOAI_KHACH` (`MA_LOAI_KHACH`),
  CONSTRAINT `khach_hang_ibfk_1` FOREIGN KEY (`MA_LOAI_KHACH`) REFERENCES `loai_khach` (`MA_LOAI_KHACH`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khach_hang`
--

LOCK TABLES `khach_hang` WRITE;
/*!40000 ALTER TABLE `khach_hang` DISABLE KEYS */;
INSERT INTO `khach_hang` VALUES (1,5,'Nguyễn Thị Hào','1970-11-07',_binary '\0','643431213','0945423362','thihao07@gmail.com','23 Nguyễn Hoàng, Đà Nẵng'),(2,3,'Phạm Xuân Diệu','1992-08-08',_binary '','865342123','0954333333','xuandieu92@gmail.com','K77/22 Thái Phiên, Quảng Trị'),(3,1,'Trương Đình Nghệ','1990-02-27',_binary '','488645199','0373213122','nghenhan2702@gmail.com','K323/12 Ông Ích Khiêm, Vinh'),(4,1,'Dương Văn Quan','1981-07-08',_binary '','543432111','0490039241','duongquan@gmail.com','K453/12 Lê Lợi, Đà Nẵng'),(5,4,'Hoàng Trần Nhi Nhi','1995-12-09',_binary '\0','795453345','0312345678','nhinhi123@gmail.com','224 Lý Thái Tổ, Gia Lai'),(6,4,'Tôn Nữ Mộc Châu','2005-12-06',_binary '\0','732434215','0988888844','tonnuchau@gmail.com','37 Yên Thế, Đà Nẵng'),(7,1,'Nguyễn Mỹ Kim','1984-04-08',_binary '\0','856453123','0912345698','kimcuong84@gmail.com','K123/45 Lê Lợi, Hồ Chí Minh'),(8,3,'Nguyễn Thị Hào','1999-04-08',_binary '\0','965656433','0763212345','haohao99@gmail.com','55 Nguyễn Văn Linh, Kon Tum'),(9,1,'Trần Đại Danh','1994-07-01',_binary '','432341235','0643343433','danhhai99@gmail.com','24 Lý Thường Kiệt, Quảng Ngãi'),(10,2,'Nguyễn Tâm Đắc','1989-07-01',_binary '','344343432','0987654321','dactam@gmail.com','22 Ngô Quyền, Đà Nẵng');
/*!40000 ALTER TABLE `khach_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kieu_thue`
--

DROP TABLE IF EXISTS `kieu_thue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kieu_thue` (
  `MA_KIEU_THUE` int NOT NULL AUTO_INCREMENT,
  `TEN_KIEU_THUE` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_KIEU_THUE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kieu_thue`
--

LOCK TABLES `kieu_thue` WRITE;
/*!40000 ALTER TABLE `kieu_thue` DISABLE KEYS */;
INSERT INTO `kieu_thue` VALUES (1,'year'),(2,'month'),(3,'day'),(4,'hour');
/*!40000 ALTER TABLE `kieu_thue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loai_dich_vu`
--

DROP TABLE IF EXISTS `loai_dich_vu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loai_dich_vu` (
  `MA_LOAI_DICH_VU` int NOT NULL AUTO_INCREMENT,
  `TEN_LOAI_DICH_VU` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_LOAI_DICH_VU`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loai_dich_vu`
--

LOCK TABLES `loai_dich_vu` WRITE;
/*!40000 ALTER TABLE `loai_dich_vu` DISABLE KEYS */;
INSERT INTO `loai_dich_vu` VALUES (1,'Villa'),(2,'House'),(3,'Room');
/*!40000 ALTER TABLE `loai_dich_vu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loai_khach`
--

DROP TABLE IF EXISTS `loai_khach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loai_khach` (
  `MA_LOAI_KHACH` int NOT NULL AUTO_INCREMENT,
  `TEN_LOAI_KHACH` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MA_LOAI_KHACH`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loai_khach`
--

LOCK TABLES `loai_khach` WRITE;
/*!40000 ALTER TABLE `loai_khach` DISABLE KEYS */;
INSERT INTO `loai_khach` VALUES (1,'Diamond'),(2,'Platinium'),(3,'Gold'),(4,'Silver'),(5,'Member');
/*!40000 ALTER TABLE `loai_khach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhan_vien`
--

DROP TABLE IF EXISTS `nhan_vien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhan_vien` (
  `MANHANVIEN` int NOT NULL AUTO_INCREMENT,
  `HO_TEN` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NGAY_SINH` date DEFAULT NULL,
  `SO_CMND` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `LUONG` float DEFAULT NULL,
  `SO_DT` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `EMAIL` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `DIA_CHI` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `MA_VI_TRI` int DEFAULT NULL,
  `MA_TRINH_DO` int DEFAULT NULL,
  `MA_BO_PHAN` int DEFAULT NULL,
  PRIMARY KEY (`MANHANVIEN`),
  KEY `MA_VI_TRI` (`MA_VI_TRI`),
  KEY `MA_TRINH_DO` (`MA_TRINH_DO`),
  KEY `MA_BO_PHAN` (`MA_BO_PHAN`),
  CONSTRAINT `nhan_vien_ibfk_1` FOREIGN KEY (`MA_VI_TRI`) REFERENCES `vi_tri` (`MA_VI_TRI`),
  CONSTRAINT `nhan_vien_ibfk_2` FOREIGN KEY (`MA_TRINH_DO`) REFERENCES `trinh_do` (`MA_TRINH_DO`),
  CONSTRAINT `nhan_vien_ibfk_3` FOREIGN KEY (`MA_BO_PHAN`) REFERENCES `bo_phan` (`MA_BO_PHAN`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhan_vien`
--

LOCK TABLES `nhan_vien` WRITE;
/*!40000 ALTER TABLE `nhan_vien` DISABLE KEYS */;
INSERT INTO `nhan_vien` VALUES (1,'Nguyễn Văn An','1970-11-07','456231786',10000000,'0901234121','annguyen@gmail.com','295 Nguyễn Tất Thành, Đà Nẵng',1,3,1),(2,'Lê Văn Bình','1997-04-09','654231234',7000000,'0934212314','binhlv@gmail.com','22 Yên Bái, Đà Nẵng',1,2,2),(3,'Hồ Thị Yến','1995-12-12','999231723',14000000,'0412352315','thiyen@gmail.com','K234/11 Điện Biên Phủ, Gia Lai',1,3,2),(4,'Võ Công Toản','1980-04-04','123231365',17000000,'0374443232','toan0404@gmail.com','77 Hoàng Diệu, Quảng Trị',1,4,4),(5,'Nguyễn Bỉnh Phát','1999-12-09','454363232',6000000,'0902341231','phatphat@gmail.com','43 Yên Bái, Đà Nẵng',2,1,1),(6,'Khúc Nguyễn An Nghi','2000-11-08','964542311',7000000,'0978653213','annghi20@gmail.com','294 Nguyễn Tất Thành, Đà Nẵng',2,2,3),(7,'Nguyễn Hữu Hà','1993-01-01','534323231',8000000,'0941234553','nhh0101@gmail.com','4 Nguyễn Chí Thanh, Huế',2,3,2),(8,'Nguyễn Hà Đông','1989-09-03','234414123',9000000,'0642123111','donghanguyen@gmail.com','111 Hùng Vương, Hà Nội',2,4,4),(9,'Tòng Hoang','1982-09-03','256781231',6000000,'0245144444','hoangtong@gmail.com','213 Hàm Nghi, Đà Nẵng',2,4,4),(10,'Nguyễn Công Đạo','1994-01-08','755434343',8000000,'0988767111','nguyencongdao12@gmail.com','6 Hòa Khánh, Đồng Nai',2,3,2);
/*!40000 ALTER TABLE `nhan_vien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trinh_do`
--

DROP TABLE IF EXISTS `trinh_do`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trinh_do` (
  `MA_TRINH_DO` int NOT NULL AUTO_INCREMENT,
  `TEN_TRINH_DO` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MA_TRINH_DO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trinh_do`
--

LOCK TABLES `trinh_do` WRITE;
/*!40000 ALTER TABLE `trinh_do` DISABLE KEYS */;
INSERT INTO `trinh_do` VALUES (1,'Trung Cấp'),(2,'Cao Đẳng'),(3,'Đại Học'),(4,'Sau Đại Học');
/*!40000 ALTER TABLE `trinh_do` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vi_tri`
--

DROP TABLE IF EXISTS `vi_tri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vi_tri` (
  `MA_VI_TRI` int NOT NULL AUTO_INCREMENT,
  `TEN_VI_TRI` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MA_VI_TRI`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vi_tri`
--

LOCK TABLES `vi_tri` WRITE;
/*!40000 ALTER TABLE `vi_tri` DISABLE KEYS */;
INSERT INTO `vi_tri` VALUES (1,'Quản Lý'),(2,'Nhân Viên');
/*!40000 ALTER TABLE `vi_tri` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 20:45:42
