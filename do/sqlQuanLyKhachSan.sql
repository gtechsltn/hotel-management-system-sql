﻿create database QuanLyKhachSan

use QuanLyKhachSan

create table LOAIPHONG	
(
	MaLoaiPhong char(5) primary key,
	TenLoaiPhong varchar(50),
	DonGiaThue float
)

create table PHONG
(
	MaPhong char(5) primary key,
	TenPhong varchar(50),
	MaLoaiPhong char(5),
	GhiChu varchar(300),

	foreign key(MaLoaiPhong) references LOAIPHONG(MaLoaiPhong)
)

create table TINHTRANG
(
	MaTinhTrang char(5) primary key,
	LoaiTinhTrang char(15),
	MaPhong char(5),
	Ngay smalldatetime,

	foreign key (MaPhong) references PHONG(MaPhong)
)

create table LOAIKHACHHANG
(
	MaLoaiKhachHang char(5) primary key,
	TenLoaiKhachHang varchar(50),
	HeSoKhach float
)

create table HOADON
(
	MaHoaDon char(5) primary key,
	TenKhachHangHD varchar(50),
	DiaChiKhachHD varchar(100),
	TriGiaHoaDon float
)

create table PHIEUTHUE
(
	MaPhieuthue char(5) primary key,
	MaPhong char(5),
	foreign key (MaPhong) references PHONG(MaPhong),

	NgayTraPhong smalldatetime,
	NgayBatDauThue smalldatetime, 
	DonGiaThueThucTe float,
	ThanhTienPhong float,

	MaHoaDon char(5),
	foreign key (MaHoaDon) references HOADON(MaHoaDon),

	PhuThuThucTe float,
)

create table CHITIETPHIEUTHUE
(
	 MaChiTietPhieuThue char(5) primary key,
	 MaPhieuThue char(5),
	 foreign key (MaPhieuThue) references PHIEUTHUE(MaPhieuThue),

	 TenKhachHang varchar(50),
	 MaLoaiKhachHang char(5),
	 foreign key (MaLoaiKhachHang) references LOAIKHACHHANG(MaLoaiKhachHang),

	 CMND varchar(50),
	 DiaChi varchar(100),
	 HeSoThucTe float
)

create table THAMSO
(
	SoKhachToiDa int,
	TiLePhuThu float
)

create table BAOCAODOANHTHU
(
	MaBaoCaoDoanhThu char(5) primary key,
	ThangBaoCaoDoanhThu smalldatetime,
	TongDoanhThu float
)


create table CHITIETBAOCAODT
(
	MaChiTietBaoCaoDT char(5) primary key,
	MaBaoCaoDoanhThu char(5),
	foreign key (MaBaoCaoDoanhThu) references BAOCAODOANHTHU(MaBaoCaoDoanhThu),

	MaLoaiPhong char(5),
	foreign key (MaLoaiPhong) references LOAIPHONG(MaLoaiPhong),
	
	DoanhThuLoaiPhong float,
	TiLeDoanhThu float
)


create table BAOCAOMATDO
(
	MaBaoCaoMatDo char(5) primary key,
	ThangBaoCaoMatDo smalldatetime,
)

create table CHITIETBAOCAOMD
(
	MaChiTietBaoCaoMD char(5) primary key,
	MaBaoCaoMatDo char(5),
	foreign key (MaBaoCaoMatDo) references BAOCAOMATDO(MaBaoCaoMatDo),

	MaPhong char(5),
	foreign key (MaPhong) references PHONG(MaPhong),

	SoNgayThueTrongThang int,
	TiLeSuDung float
)


-- tạo mã tự động tăng

if exists (select * from sysobjects where name = 'LOAIPHONG' and type = 'P')
    drop procedure NewLoaiPhong
go
CREATE PROCEDURE NewLoaiPhong

     @LoaiPhongName VARCHAR(50),
     @DonGiaThue float

AS BEGIN

-- on show: X row(s) affected 
--SET NOCOUNT ON  

     IF exists (SELECT *FROM LOAIPHONG)
     BEGIN
		 INSERT INTO LOAIPHONG(MaLoaiPhong, TenLoaiPhong, DonGiaThue)
		 SELECT 
				'LP' + RIGHT('000' + CAST(LoaiPhong_ID + 1 AS NVARCHAR(3)), 3)
			  , @LoaiPhongName
			  ,@DonGiaThue
		 FROM (
			  SELECT TOP 1 LoaiPhong_ID = CAST(RIGHT(MaLoaiPhong, 3) AS INT)
			  FROM LOAIPHONG
			  ORDER BY MaLoaiPhong DESC
		 ) t
	END
	ELSE
	BEGIN
		INSERT INTO LOAIPHONG(MaLoaiPhong, TenLoaiPhong, DonGiaThue) VALUES ('LP000',@LoaiPhongName, @DonGiaThue)
	END
END 

-- Select all LoaiPhong
CREATE PROCEDURE selectAllLoaiPhong
As begin
	Select MaLoaiPhong, TenLoaiPhong, DonGiaThue
	From LOAIPHONG
end


---------------------
-----------------

EXEC NewLoaiPhong 'VIP', 120000
EXEC NewLoaiPhong 'GOLD', 140000
EXEC NewLoaiPhong 'STANDAR', 100000

EXEC selectAllLoaiPhong


SELECT *FROM LOAIPHONG