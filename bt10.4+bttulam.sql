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


--e. Dùng while cập nhật bản ghi
create table T1(
ma int primary key,
ten Nvarchar(30)
);

declare @id int = 0;
while @id < 18
begin 
	set @id += 1
	insert into T1 
		values
		(@id, N'Bản ghi thứ ' + cast(@id as nvarchar(10)));
end

select * from t1


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




--Bài tập về nhà
create database QuanLyPhong_TQ_Trong
go
use QuanLyPhong_TQ_Trong

--Bảng Phòng
create table Phong
(
MaPhong char(5) primary key,
TenPhong NVarchar(50),
MaTP int 
);
go

-- Bảng Nhân viên
CREATE TABLE NhanVien (
    MaNV CHAR(5) PRIMARY KEY,             
    Hoten NVARCHAR(50) NOT NULL,         
    Gioitinh CHAR(5),                  
    Maphong CHAR(5),                   
    Luong INT,                          
    Ngaysinh DATETIME,               
    Quequan NVARCHAR(50),                
    FOREIGN KEY (Maphong) REFERENCES phong(Maphong)
);
go

-- Bảng Địa điểm phòng
CREATE TABLE Diadiemphong (
    Maphong CHAR(5),       
    Diadiem VARCHAR(50),
	CONSTRAINT FK_Diadiemphong_Phong FOREIGN KEY (Maphong) REFERENCES Phong(MaPhong)
);
go

-- Bảng Dự án
CREATE TABLE Duan (
    MaDA CHAR(5) PRIMARY KEY,           
    TenDA VARCHAR(50) NOT NULL,
    DiadiemDA VARCHAR(50),              
    Maphong CHAR(5),              
    FOREIGN KEY (Maphong) REFERENCES Phong(Maphong)
);
go

--Bảng chấm công
create table ChamCong
(
MaNV char(5),
MaDA char(5),
Sogio int,
CONSTRAINT FK_ChamCong_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
CONSTRAINT FK_ChamCong_MaDA FOREIGN KEY (MaDA) REFERENCES Duan(MaDA)
);
go

-- Bảng Phòng
INSERT INTO Phong VALUES 
('P01', N'Phòng Kế toán', 1),
('P02', N'Phòng Nhân sự', 2),
('P03', N'Phòng IT', 3),
('P04', N'Phòng Kinh doanh', 4),
('P05', N'Phòng Marketing', 5),
('P06', N'Phòng R&D', 6),
('P07', N'Phòng Pháp chế', 7),
('P08', N'Phòng QA', 8),
('P09', N'Phòng Bảo vệ', 9),
('P10', N'Phòng Hành chính', 10);
go

-- Bảng Nhân viên
INSERT INTO NhanVien VALUES
('NV01', N'Nguyễn Văn An', 'Nam', 'P01', 4000000, '1990-05-10', N'Hà Nội'),
('NV02', N'Trần Thị Bình', 'Nữ', 'P02', 6000000, '1985-08-12', N'Hải Phòng'),
('NV03', N'Lê Văn Cường', 'Nam', 'P03', 4500000, '1992-11-23', N'Hà Nội'),
('NV04', N'Hoàng Thị Dung', 'Nữ', 'P04', 8000000, '1980-01-01', N'Hà Nội'),
('NV05', N'Phạm Văn An', 'Nam', 'P05', 3000000, '1995-07-07', N'Thanh Hóa'),
('NV06', N'Đỗ Thị Lan', 'Nữ', 'P06', 5000000, '1991-09-09', N'Hà Nội'),
('NV07', N'Nguyễn Văn Nam', 'Nam', 'P07', 9000000, '1975-12-30', N'Nghệ An'),
('NV08', N'Lê Thị An', 'Nữ', 'P08', 7000000, '1988-03-03', N'Hà Nội'),
('NV09', N'Phạm Văn Hùng', 'Nam', 'P09', 5500000, '1993-04-15', N'Đà Nẵng'),
('NV10', N'Hoàng Văn Tuấn', 'Nam', 'P10', 4800000, '1989-06-20', N'Hà Nội');
go

-- Bảng Địa điểm phòng
INSERT INTO Diadiemphong VALUES
('P01', N'Tầng 1'),
('P02', N'Tầng 2'),
('P03', N'Tầng 3'),
('P04', N'Tầng 4'),
('P05', N'Tầng 5'),
('P06', N'Tầng 6'),
('P07', N'Tầng 7'),
('P08', N'Tầng 8'),
('P09', N'Tầng 9'),
('P10', N'Tầng 10');
go

-- Bảng Dự án
INSERT INTO Duan VALUES
('DA01', 'Hệ thống ERP', 'Hà Nội', 'P03'),
('DA02', 'Website công ty', 'Hà Nội', 'P03'),
('DA03', 'Chiến dịch Marketing A', 'HCM', 'P05'),
('DA04', 'Sản phẩm R&D 1', 'Đà Nẵng', 'P06'),
('DA05', 'Mở rộng thị trường', 'Hà Nội', 'P04'),
('DA06', 'Tái cấu trúc tổ chức', 'HCM', 'P02'),
('DA07', 'Kiểm toán nội bộ', 'Hà Nội', 'P01'),
('DA08', 'An ninh mạng', 'Hà Nội', 'P07'),
('DA09', 'QA cải tiến', 'Hà Nội', 'P08'),
('DA10', 'Dự án Bảo vệ', 'Hà Nội', 'P09');
go

-- Bảng Chấm công
INSERT INTO ChamCong VALUES
('NV01', 'DA07', 8),
('NV02', 'DA06', 12),
('NV03', 'DA01', 20),
('NV04', 'DA05', 55),
('NV05', 'DA03', 9),
('NV06', 'DA04', 15),
('NV07', 'DA08', 40),
('NV08', 'DA09', 30),
('NV09', 'DA10', 25),
('NV10', 'DA02', 5);
go


