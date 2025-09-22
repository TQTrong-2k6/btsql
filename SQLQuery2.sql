use QuanLySinhVien

create login sv100 with password = '1';

create user u100 for login sv100;

grant select, update on dbo.SinhVien to u100;

CREATE USER u100 FOR LOGIN sv100;

select * from SinhVien

revoke select, update on sinhvien
from u100

create index indexName on dbo.SinhVien(masv)



declare @i int
set @i = 1
while @i < 10
begin
	print @i
	set @i = @i + 2
end
go

declare @SoluongSV_Nam int
select @soluongsv_nam = count(gioitinh) from SinhVien
where GioiTinh = 'nam'








--bai 3
declare @thu int 
set @thu = 1
while  @thu<=7
begin
set @thu=@thu +1;
if(@thu = 2)
print N'Thời khóa biểu thứ 2 :học lí thuyết';
else if(@thu=3)
print N'Thời khóa biểu thứ 3 : học tiếng anh';
else if(@thu=4)
print N'Thời khóa biểu thứ 4 : học thực hành';
else if(@thu=5)
print N'Thời khóa biểu thứ 5 : học lí thuyết';
else if(@thu=6)
print N'Thời khóa biểu thứ 6 : học lí thuyết';
else if (@thu=7)
print N'Thời khóa biểu thứ 7: học thực hành';
else print N'Chủ nhật : Nghỉ ngơi';
end;


--a, Dem so sinh vien
declare @tongSoSV int
select @tongSOsv = count(masv) from SinhVien
if @tongSoSV > 100
begin
	Print 'So luong sv da vuot qua 100'
end
else
begin
	print 'so luong sv hop le'
end


--b. Tinh chat mon hoc
select MaMH as 'Mã môn học', TenMH as 'Tên môn học',
	case
		when sotinchi >= 6 then N'Thực tập đồ án'
		when sotinchi >= 4 and SoTinChi < 6 then N'Cơ sở ngành, chuyên ngành'
		when sotinchi < 4 then N'Cơ bản'
	end
from MonHoc



--c. Xếp loại sv
select sv.MaSV, sv.HoTen, sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) as [Điểm trung bình], 
			case
				when sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) >= 9 then N'Xuất sắc'
				when sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) < 9 and sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) >= 8 then N'Giỏi'
				when sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) < 8 and sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) >= 7 then N'khá'
				when sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) < 7 and sum(d.Diem * mh.SoTinChi)/sum(mh.SoTinChi) >=6 then N'Trung bình'
				else N'Yếu'
			end as N'Xếp loại'
from SinhVien sv 
join diem d on d.MaSV = sv.MaSV
join MonHoc mh on mh.MaMH = d.MaMH
group by sv.MaSV, sv.HoTen


--d. In ra bug
DECLARE @st NVARCHAR(5) 
SELECT  @st = SoTinChi FROM monhoc  
PRINT   CONVERT(DateTime, @ST)

use Tran_Quang_Trong
--e. Dùng while cập nhật bản ghi
create table T1(
ma int primary key,
ten Nvarchar(30)
);

declare @id int = 1;
while @id < 18
begin 
	insert into T1 
		values
		(@id, N'Bản ghi thứ ' + cast(@id as nvarchar(10)));
	set @id += 2
end

declare @soluongbanghi int
select @soluongbanghi = count(ten) from t1
print N'Số lượng bản ghi là: ' + cast(@soluongbanghi as Nvarchar(10));


delete t1
--f. Add cột địa điểm
alter table khoa add DiaDiem varchar(3)


update khoa set diadiem = 
case
	when tenkhoa = N'Khoa Công nghệ thông tin' or 
	tenkhoa = N'Khoa Kinh tế' or 
	tenkhoa = N'Khoa Ngoại ngữ' or 
	tenkhoa = N'Khoa Toán ứng dụng' 
	then 'cs2'
	when tenkhoa = N'Khoa Điện tử viễn thông' or 
	tenkhoa = N'Khoa Cơ khí' or 
	tenkhoa = N'Khoa Vật lý' or 
	tenkhoa = N'Khoa Hóa học' 
	then 'cs1'
	else 'cs3'
end

select * from khoa






CREATE DATABASE Tran_Quang_Trong_QLBH;
GO
USE Tran_Quang_Trong_QLBH;
GO

-- Bảng LoaiHang
CREATE TABLE LoaiHang (
    LoaihangID CHAR(10) PRIMARY KEY,
    TenLH NVARCHAR(60)
);

-- Bảng MatHang
CREATE TABLE MatHang (
    MathangID CHAR(10) PRIMARY KEY,
    LoaihangID CHAR(10),
    Tenhang NVARCHAR(50),
    Dvtinh NVARCHAR(30),
    Slton TINYINT,
    FOREIGN KEY (LoaihangID) REFERENCES LoaiHang(LoaihangID)
);

-- Bảng NHACC (Nhà cung cấp)
CREATE TABLE NHACC (
    NhacCcid CHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(30),
    diachiNCC NVARCHAR(50),
    SdtNCC CHAR(11)
);

-- Bảng NhanVien
CREATE TABLE NhanVien (
    NhanvienID CHAR(10) PRIMARY KEY,
    HotenNV NVARCHAR(30),
    GioitinhNV NVARCHAR(10),
    NgaysinhNV DATE,
    diachiNV NVARCHAR(50),
    EmailNV CHAR(30),
    SdtNV CHAR(11)
);

-- Bảng DonHangNhap
CREATE TABLE Donhangnhap (
    DonhangnhapID CHAR(10) PRIMARY KEY,
    NhanvienID CHAR(10),
    NhacCcid CHAR(10),
    Ngaynhap DATETIME,
    FOREIGN KEY (NhanvienID) REFERENCES NhanVien(NhanvienID),
    FOREIGN KEY (NhacCcid) REFERENCES NHACC(NhacCcid)
);

-- Bảng ChiTietDHN
CREATE TABLE ChiTietDHN (
    DonhangnhapID CHAR(10),
    MathangID CHAR(10),
    Slnhap TINYINT,
    DGnhap FLOAT,
    PRIMARY KEY (DonhangnhapID, MathangID),
    FOREIGN KEY (DonhangnhapID) REFERENCES Donhangnhap(DonhangnhapID),
    FOREIGN KEY (MathangID) REFERENCES MatHang(MathangID)
);

-- Bảng KhachHang
CREATE TABLE KhachHang (
    KhachhangID CHAR(10) PRIMARY KEY,
    HotenKH NVARCHAR(30),
    DiachiKH NVARCHAR(50),
    EmailKH CHAR(30),
    SdtKH CHAR(11)
);

-- Bảng Donhangban
CREATE TABLE Donhangban (
    DonhangbanID CHAR(10) PRIMARY KEY,
    KhachhangID CHAR(10),
    Ngayban DATETIME,
    Trietkhauban FLOAT,
    FOREIGN KEY (KhachhangID) REFERENCES KhachHang(KhachhangID)
);

-- Bảng ChiTietDHB
CREATE TABLE ChiTietDHB (
    DonhangbanID CHAR(10),
    MathangID CHAR(10),
    Slban TINYINT,
    DGban FLOAT,
    PRIMARY KEY (DonhangbanID, MathangID),
    FOREIGN KEY (DonhangbanID) REFERENCES Donhangban(DonhangbanID),
    FOREIGN KEY (MathangID) REFERENCES MatHang(MathangID)
);

--insert data
--LoaiHang
INSERT INTO LoaiHang VALUES
('LH01', N'Đồ uống'), 
('LH02', N'Bánh kẹo'), 
('LH03', N'Gia vị'),
('LH04', N'Đồ hộp'), 
('LH05', N'Sữa'), 
('LH06', N'Đồ khô'),
('LH07', N'Rau củ'), 
('LH08', N'Trái cây'), 
('LH09', N'Đồ đông lạnh'), 
('LH10', N'Gia dụng');

-- MatHang
INSERT INTO MatHang VALUES
('MH01','LH01',N'Coca Cola','Lon',100),
('MH02','LH01',N'Pepsi','Lon',80),
('MH03','LH02',N'Bánh Oreo','Hộp',40),
('MH04','LH02',N'Bánh Cosy','Gói',55),
('MH05','LH03',N'Đường tinh luyện','Kg',70),
('MH06','LH03',N'Muối Iốt','Kg',60),
('MH07','LH05',N'Sữa Vinamilk','Lốc',30),
('MH08','LH05',N'Sữa TH True Milk','Lốc',20),
('MH09','LH09',N'Xúc xích CP','Gói',90),
('MH10','LH09',N'Chả cá đông lạnh','Kg',10);

-- NHACC
INSERT INTO NHACC VALUES
('NCC01',N'Nam Phát',N'Hà Nội','0911111111'),
('NCC02',N'An Bình',N'HCM','0922222222'),
('NCC03',N'Thành Công',N'Hải Phòng','0933333333'),
('NCC04',N'Long Phú',N'HCM','0944444444'),
('NCC05',N'Hưng Thịnh',N'Hà Nội','0955555555'),
('NCC06',N'Phương Nam',N'HCM','0966666666'),
('NCC07',N'Đại Lộc',N'Đà Nẵng','0977777777'),
('NCC08',N'Trường An',N'Hà Nội','0988888888'),
('NCC09',N'Tuấn Phát',N'Cần Thơ','0999999999'),
('NCC10',N'Minh Anh',N'HCM','0900000000');

-- NhanVien
INSERT INTO NhanVien VALUES
('NV01',N'Nguyễn Văn A','Nam','1990-01-01',N'Hà Nội','a@mail.com','0911111111'),
('NV02',N'Trần Thị B','Nữ','1992-02-02',N'HCM','b@mail.com','0922222222'),
('NV03',N'Lê Văn C','Nam','1989-03-03',N'Hải Phòng','c@mail.com','0933333333'),
('NV04',N'Nguyễn Văn D','Nam','1995-04-04',N'HCM','d@mail.com','0944444444'),
('NV05',N'Trần Thị E','Nữ','1996-05-05',N'Hà Nội','e@mail.com','0955555555'),
('NV06',N'Nguyễn Văn F','Nam','1993-06-06',N'Đà Nẵng','f@mail.com','0966666666'),
('NV07',N'Nguyễn Văn G','Nam','1994-07-07',N'Hà Nội','g@mail.com','0977777777'),
('NV08',N'Trần Thị H','Nữ','1997-08-08',N'HCM','h@mail.com','0988888888'),
('NV09',N'Nguyễn Văn I','Nam','1998-09-09',N'Hải Dương','i@mail.com','0999999999'),
('NV10',N'Trần Thị K','Nữ','1999-10-10',N'Hà Nội','k@mail.com','0900000000');

-- Donhangnhap
INSERT INTO Donhangnhap VALUES
('DN01','NV01','NCC01','2025-09-01'),
('DN02','NV02','NCC02','2025-09-02'),
('DN03','NV03','NCC03','2025-09-03'),
('DN04','NV04','NCC04','2025-09-04'),
('DN05','NV05','NCC05','2025-09-05'),
('DN06','NV06','NCC06','2025-09-06'),
('DN07','NV07','NCC07','2025-09-07'),
('DN08','NV08','NCC08','2025-09-08'),
('DN09','NV09','NCC09','2025-09-09'),
('DN10','NV10','NCC10','2025-09-10');

-- ChiTietDHN
INSERT INTO ChiTietDHN VALUES
('DN01','MH01',60,500000),
('DN02','MH02',70,550000),
('DN03','MH03',30,300000),
('DN04','MH04',40,350000),
('DN05','MH05',90,200000),
('DN06','MH06',55,250000),
('DN07','MH07',45,600000),
('DN08','MH08',20,620000),
('DN09','MH09',100,700000),
('DN10','MH10',10,750000);

-- KhachHang
INSERT INTO KhachHang VALUES
('KH01',N'Nguyễn A',N'Hà Nội','kh1@mail.com','0911111111'),
('KH02',N'Trần B',N'HCM','kh2@mail.com','0922222222'),
('KH03',N'Lê C',N'Hải Phòng','kh3@mail.com','0933333333'),
('KH04',N'Phạm D',N'Hà Nội','kh4@mail.com','0944444444'),
('KH05',N'Ngô E',N'HCM','kh5@mail.com','0955555555'),
('KH06',N'Đinh F',N'Hà Nội','kh6@mail.com','0966666666'),
('KH07',N'Đỗ G',N'Đà Nẵng','kh7@mail.com','0977777777'),
('KH08',N'Bùi H',N'Hà Nội','kh8@mail.com','0988888888'),
('KH09',N'Cao I',N'HCM','kh9@mail.com','0999999999'),
('KH10',N'Vũ K',N'Hải Dương','kh10@mail.com','0900000000');

-- Donhangban
INSERT INTO Donhangban VALUES
('DB01','KH01','2025-09-05',0.05),
('DB02','KH02','2025-09-10',0.1),
('DB03','KH03','2025-09-15',0.15),
('DB04','KH04','2025-09-18',0.2),
('DB05','KH05','2025-09-21',0.1),
('DB06','KH06','2025-09-23',0.05),
('DB07','KH07','2025-09-25',0.1),
('DB08','KH08','2025-09-27',0.15),
('DB09','KH09','2025-09-29',0.05),
('DB10','KH10','2025-09-30',0.1);

-- ChiTietDHB
INSERT INTO ChiTietDHB VALUES
('DB01','MH01',40,700000),
('DB02','MH02',60,720000),
('DB03','MH03',110,350000),
('DB04','MH04',80,360000),
('DB05','MH05',10,220000),
('DB06','MH06',55,260000),
('DB07','MH07',100,700000),
('DB08','MH08',20,650000),
('DB09','MH09',130,750000),
('DB10','MH10',5,770000);


declare @soluongMH int
select @soluongMH = count(mh.MathangID) from mathang mh
join ChiTietDHN ctdhn on ctdhn.MathangID = mh.MathangID
join Donhangnhap dhn on dhn.DonhangnhapID = ctdhn.DonhangnhapID
where dhn.