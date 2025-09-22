CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
-- Bảng Khoa
CREATE TABLE Khoa (
    MaKhoa CHAR(5) PRIMARY KEY,
    TenKhoa NVARCHAR(100) NOT NULL
);

-- Bảng Lớp
CREATE TABLE Lop (
    MaLop CHAR(10) PRIMARY KEY,
    TenLop NVARCHAR(100) NOT NULL,
    MaKhoa CHAR(5),
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

-- Bảng Sinh viên
CREATE TABLE SinhVien (
    MaSV CHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh char(3),
    MaLop CHAR(10),
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);

-- Bảng Môn học
CREATE TABLE MonHoc (
    MaMH CHAR(10) PRIMARY KEY,
    TenMH NVARCHAR(100) NOT NULL,
    SoTinChi INT NOT NULL
);

-- Bảng Điểm
CREATE TABLE Diem (
    MaSV CHAR(10),
    MaMH CHAR(10),
    Diem FLOAT CHECK(Diem BETWEEN 0 AND 10),
    PRIMARY KEY (MaSV, MaMH),
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- ======================
-- Dữ liệu bảng Khoa
-- ======================
INSERT INTO Khoa (MaKhoa, TenKhoa) 
VALUES 
		('K001', N'Khoa Công nghệ thông tin'),
		('K002', N'Khoa Điện tử viễn thông'),
		('K003', N'Khoa Kinh tế'),
		('K004', N'Khoa Cơ khí'),
		('K005', N'Khoa Hóa học'),
		('K006', N'Khoa Sinh học'),
		('K007', N'Khoa Vật lý'),
		('K008', N'Khoa Toán ứng dụng'),
		('K009', N'Khoa Ngoại ngữ'),
		('K010', N'Khoa Luật'),
		('K011', N'Khoa Y học'),
		('K012', N'Khoa Kiến trúc'),
		('K013', N'Khoa Du lịch'),
		('K014', N'Khoa Môi trường'),
		('K015', N'Khoa Thể dục thể thao');

-- ======================
-- Dữ liệu bảng Lop
-- ======================
INSERT INTO Lop (MaLop, TenLop, MaKhoa) 
VALUES 
		('L001', N'Lớp CNTT1', 'K001'),
		('L002', N'Lớp CNTT2', 'K001'),
		('L003', N'Lớp ĐTVT1', 'K002'),
		('L004', N'Lớp ĐTVT2', 'K002'),
		('L005', N'Lớp Kinh tế1', 'K003'),
		('L006', N'Lớp Cơ khí1', 'K004'),
		('L007', N'Lớp Hóa học1', 'K005'),
		('L008', N'Lớp Sinh học1', 'K006'),
		('L009', N'Lớp Vật lý1', 'K007'),
		('L010', N'Lớp Toán1', 'K008'),
		('L011', N'Lớp Ngoại ngữ1', 'K009'),
		('L012', N'Lớp Luật1', 'K010'),
		('L013', N'Lớp Y học1', 'K011'),
		('L014', N'Lớp Kiến trúc1', 'K012'),
		('L015', N'Lớp Du lịch1', 'K013');

-- ======================
-- Dữ liệu bảng SinhVien
-- ======================
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, GioiTinh, MaLop) 
VALUES 
		('SV001', N'Nguyễn Văn A', '2002-03-15', 'Nam', 'L001'),
		('SV002', N'Trần Thị B', '2003-07-22', N'Nữ', 'L001'),
		('SV003', N'Lê Văn C', '2002-11-05', 'Nam', 'L002'),
		('SV004', N'Phạm Thị D', '2004-01-19', N'Nữ', 'L002'),
		('SV005', N'Hoàng Văn E', '2003-05-10', 'Nam', 'L003'),
		('SV006', N'Đỗ Thị F', '2002-09-28', N'Nữ', 'L004'),
		('SV007', N'Ngô Văn G', '2003-12-03', 'Nam', 'L005'),
		('SV008', N'Vũ Thị H', '2002-06-14', N'Nữ', 'L006'),
		('SV009', N'Bùi Văn I', '2004-08-07', 'Nam', 'L007'),
		('SV010', N'Đinh Thị J', '2002-10-25', N'Nữ', 'L008'),
		('SV011', N'Nguyễn Văn K', '2003-02-18', 'Nam', 'L009'),
		('SV012', N'Trần Thị L', '2002-12-12', N'Nữ', 'L010'),
		('SV013', N'Lê Văn M', '2003-03-03', 'Nam', 'L011'),
		('SV014', N'Phạm Thị N', '2002-07-29', N'Nữ', 'L012'),
		('SV015', N'Hoàng Văn O', '2004-04-16', 'Nam', 'L013');

-- ======================
-- Dữ liệu bảng MonHoc
-- ======================
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH001', N'Cơ sở dữ liệu', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH002', N'Mạng máy tính', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH003', N'Lập trình C++', 4);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH004', N'Lập trình Java', 4);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH005', N'Phân tích thiết kế HTTT', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH006', N'Kinh tế vi mô', 2);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH007', N'Kinh tế vĩ mô', 2);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH008', N'Hóa đại cương', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH009', N'Sinh học phân tử', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH010', N'Vật lý đại cương', 4);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH011', N'Toán cao cấp', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH012', N'Ngoại ngữ cơ bản', 2);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH013', N'Luật dân sự', 3);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH014', N'Kiến trúc công trình', 4);
INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES ('MH015', N'Du lịch bền vững', 2);

-- ======================
-- Dữ liệu bảng Diem (mẫu cho vài SV, mỗi SV 3 môn)
-- ======================
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV001', 'MH001', 8.0);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV001', 'MH002', 7.5);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV001', 'MH003', 9.0);

INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV002', 'MH004', 6.5);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV002', 'MH005', 7.0);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV002', 'MH006', 8.5);

INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV003', 'MH007', 6.0);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV003', 'MH008', 7.2);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV003', 'MH009', 8.1);

INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV004', 'MH010', 7.7);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV004', 'MH011', 6.8);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV004', 'MH012', 8.9);

INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV005', 'MH013', 7.3);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV005', 'MH014', 9.2);
INSERT INTO Diem (MaSV, MaMH, Diem) VALUES ('SV005', 'MH015', 8.0);


select * from lop

create view tenSVvaTenKhoa as

select l.MaKhoa, count(l.malop) from lop as l
group by l.makhoa
having count(l.malop) > 1

select l.MaKhoa as 'Ma khoa', count(l.malop) as 'so luong lop' from lop as l
group by l.makhoa 
select * from khoa

select * from tenSVvaTenKhoa

drop view tenSVvaTenKhoa

use quanlysinhvien

select * from diem

select * from khoa

select * from lop

select * from monhoc

select * from sinhvien
