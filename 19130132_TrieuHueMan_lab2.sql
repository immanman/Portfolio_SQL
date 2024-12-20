create database baith2_ngk
use baith2_ngk;
go

create table NHACC
(
	MaNCC		varchar(3),
	TenNCC		nvarchar(100),
	DiaChiNCC	nvarchar(200),
	DTNCC		char(12)
	constraint pk_nhacc primary key(MaNCC)
)

create table KH
(
	MaKH		varchar(5),
	TenKH		nvarchar(100),
	DCKH		nvarchar(200),
	DTKH		char(12),
	constraint pk_kh primary key(MaKH)
)

create table LOAINGK
(
	MaLoaiNGK	varchar(3),
	TenLoaiNGK	nvarchar(50),
	MaNCC		varchar(3)
	constraint	pk_loaingk primary key(MaLoaiNGK),
	constraint	fk_nhacc_loaingk foreign key(MaNCC) references NHACC(MaNCC)
)

create table NGK
(
	MaNGK		varchar(3),
	TenNGK		nvarchar(50),
	Quycach		nvarchar(15),
	MaLoaiNGK	varchar(3),
	constraint	pk_ngk primary key(MaNGK),
	constraint	fk_loaingk_ngk foreign key(MaLoaiNGK) references LOAINGK(MaLoaiNGK)
)

create table DDH
(
	SoDDH		varchar(5),
	NgayDH		smalldatetime,
	MaNCC		varchar(3),
	constraint pk_dd primary key(SoDDH),
	constraint fk_nhacc_ddh foreign key(MaNCC) references NHACC(MaNCC)
)

create table CT_DDH
(
	SoDDH		varchar(5),
	MaNGK		varchar(3),
	SLDat		int,
	constraint pk_ctddh primary key(SoDDH,MaNGK),
	constraint fk_ddh_ctddh foreign key(SoDDH) references DDH(SoDDH),
	constraint fk_ngk_ctddh foreign key(MaNGK) references NGK(MaNGK)
)

create table PHIEUGH
(
	SoPGH		varchar(5),
	NgayGH		smalldatetime,
	SoDDH		varchar(5),
	constraint pk_phieugh primary key(SoPGH),
	constraint fk_ddh_phieugh foreign key(SoDDH) references DDH(SoDDH)
)

create table CT_PGH
(
	SoPGH		varchar(5),
	MaNGK		varchar(3),
	SLGiao		int,
	DGGiao		int,
	constraint pk_ctphieugh primary key(SoPGH,MaNGK),
	constraint fk_phieugh_ctphieugh foreign key(SoPGH) references PHIEUGH(SoPGH),
	constraint fk_ngk_ctphieugh foreign key(MaNGK) references NGK(MaNGK)
)

create table HOADON
(
	SoHD		varchar(5),
	NgaylapHD	smalldatetime,
	MaKH		varchar(5),
	constraint pk_hoadon primary key(SoHD),
	constraint fk_kh_hoadon foreign key(MaKH) references KH(MaKH)
)

create table CT_HOADON
(
	SoHD		varchar(5),
	MaNGK		varchar(3),
	SLKHMua		int,
	DGBan		int,
	constraint pk_cthoadon primary key(SoHD,MaNGK),
	constraint fk_hoadon_cthoadon foreign key(SoHD) references HOADON(SoHD),
	constraint fk_ngk_cthoadon foreign key(MaNGK) references NGK(MaNGK)
)

create table PHIEUHEN
(
	SoPH		varchar(5),
	NgaylapPH	smalldatetime,
	NgayhenGiao	smalldatetime,
	MaKH		varchar(5),
	constraint pk_phieuhen primary key(SoPH),
	constraint fk_kh_phieuhen foreign key(MaKH) references KH(MaKH)
)

create table CT_PH
(
	SoPH		varchar(5),
	MaNGK		varchar(3),
	SLHen		int,
	constraint pk_ctphieuhen primary key(SoPH,MaNGK),
	constraint fk_ngk_ctphieuhen foreign key(MaNGK) references NGK(MaNGK)
)

create table PHIEUTRANO
(
	SoPTN		varchar(5),
	Ngaytra		smalldatetime,
	SotienTra	int,
	SoHD		varchar(5),
	constraint pk_phieutrano primary key(SoPTN),
	constraint fk_hoadon_phieutrano foreign key(SoHD) references HOADON(SoHD)
)

insert into NHACC values('NC1',N'Công ty NGK quốc tế Coca Cola',N'Xa lộ Hà Nội, Thủ Đức, TP.HCM','088967908')
insert into NHACC values('NC2',N'Công ty NGK quốc tế Pepsi',N'Bến Chương Dương, Quận 1, TP.HCM','083663366')
insert into NHACC values('NC3',N'Công ty NGK Bến Chương Dương',N'Hàm Tử, Quận 5, TP.HCM','089456677')

insert into KH values('KH01',N'Cửa hàng BT',N'144 XVNT','088405996')
insert into KH values('KH02',N'Cửa hàng trà',N'198/42 NTT','085974572')
insert into KH values('KH03',N'Siêu thị COOP',N'24 ĐTH','086547888')

insert into LOAINGK values('NK1',N'Nước ngọt có gas','NC1')
insert into LOAINGK values('NK2',N'Nước ngọt không gas','NC2')
insert into LOAINGK values('NK3',N'Trà','NC1')
insert into LOAINGK values('NK4',N'Sữa','NC2')

insert into NGK values('CC1',N'Coca Cola',N'Chai','NK1')
insert into NGK values('CC2',N'Coca Cola',N'Lon','NK1')
insert into NGK values('PS1',N'Pepsi',N'Chai','NK1')
insert into NGK values('PS2',N'Pepsi',N'Lon','NK1')
insert into NGK values('SV1',N'Seven Up',N'Chai','NK1')
insert into NGK values('SV2',N'Seven Up',N'Lon','NK1')
insert into NGK values('NO1',N'Number One',N'Chai','NK1')
insert into NGK values('NO2',N'Numbet One',N'Lon','NK1')
insert into NGK values('ST1',N'Sting dâu',N'Chai','NK1')
insert into NGK values('ST2',N'Sting dâu',N'Lon','NK1')
insert into NGK values('C2', N'Trà C2',N'Chai','NK2')
insert into NGK values('OD', N'Trà xanh 0 độ',N'Chai','NK2')
insert into NGK values('ML1',N'Sữa tươi tiệt trùng',N'Bịch','NK1')
insert into NGK values('WT1',N'Nước uống đóng chai',N'Chai','NK2')

insert into DDH values('DDH01','10/05/2011','NC1')
insert into DDH values('DDH02','05/20/2011','NC1')
insert into DDH values('DDH03','05/26/2011','NC2')
insert into DDH values('DDH04','03/06/2011','NC2')

insert into CT_DDH values('DDH01','CC1','20')
insert into CT_DDH values('DDH01','CC2','15')
insert into CT_DDH values('DDH01','PS1','18')
insert into CT_DDH values('DDH01','SV2','12')
insert into CT_DDH values('DDH02','CC2','30')
insert into CT_DDH values('DDH02','PS2','10')
insert into CT_DDH values('DDH02','SV1','5')
insert into CT_DDH values('DDH02','ST1','15')
insert into CT_DDH values('DDH02','C2','10')
insert into CT_DDH values('DDH03','OD','45')
insert into CT_DDH values('DDH04','CC1','8')
insert into CT_DDH values('DDH04','ST2','12')

insert into PHIEUGH values('PGH01','12/05/2010','DDH01')
insert into PHIEUGH values('PGH02','5/05/2010','DDH01')
insert into PHIEUGH values('PGH03','1/05/2010','DDH02')
insert into PHIEUGH values('PGH04','2/05/2010','DDH02')
insert into PHIEUGH values('PGH05','8/05/2010','DDH03')

insert into CT_PGH values('PGH01','CC1','15','5000')
insert into CT_PGH values('PGH01','CC2','15','4000')
insert into CT_PGH values('PGH01','SV2','10','4000')
insert into CT_PGH values('PGH02','SV2','2','4000')
insert into CT_PGH values('PGH03','CC2','30','5000')
insert into CT_PGH values('PGH03','PS1','10','4000')
insert into CT_PGH values('PGH03','ST1','15','9000')
insert into CT_PGH values('PGH03','C2','10','8000')

insert into HOADON values('HD01','10/05/2010','KH01')
insert into HOADON values('HD02','2/05/2010','KH01')
insert into HOADON values('HD03','5/06/2010','KH02')
insert into HOADON values('HD04','6/06/2010','KH02')
insert into HOADON values('HD05','2/06/2011','KH02')
insert into HOADON values('HD06','8/07/2010','KH03')

insert into CT_HOADON values('HD01','CC1','20','6000')
insert into CT_HOADON values('HD01','CC2','50','5000')
insert into CT_HOADON values('HD02','ST1','40','10000')
insert into CT_HOADON values('HD03','SV2','60','5000')
insert into CT_HOADON values('HD04','PS2','25','5000')

insert into PHIEUHEN values('PH01','08/05/2010','09/06/2010','KH01')
insert into PHIEUHEN values('PH02','5/05/2010','8/06/2010','KH02')
insert into PHIEUHEN values('PH03','01/06/2010','02/06/2010','KH03')

insert into CT_PH values('PH01','ST2','10')
insert into CT_PH values('PH01','OD','8')
insert into CT_PH values('PH02','CC1','20')
insert into CT_PH values('PH03','ST1','7')
insert into CT_PH values('PH03','SV2','12')
insert into CT_PH values('PH03','CC2','9')
insert into CT_PH values('PH03','PS2','15')

insert into PHIEUTRANO values('PTN01','8/05/2010','500000','HD01')
insert into PHIEUTRANO values('PTN02','01/06/2010','350000','HD01')
insert into PHIEUTRANO values('PTN03','02/06/2010','650000','HD02')
insert into PHIEUTRANO values('PTN04','5/06/2010','102000','HD03')
insert into PHIEUTRANO values('PTN05','01/07/2010','108000','HD03')

select * from NHACC
select * from KH
select * from LOAINGK
select * from NGK
select * from DDH
select * from CT_DDH
select * from PHIEUGH
select * from CT_PGH
select * from HOADON
select * from CT_HOADON
select * from PHIEUHEN
select * from CT_PH
select * from PHIEUTRANO


--VIEW 
--câu 1.Tạo View V_NGK tổng hợp dữ liệu về từng NGK đã được bán. Cấu trúc View gồm các thuộc tính:
--MaNGK, TenNGK, Quycach, SoLuongBan,Tổng tiền= SoLuongBan*Đơn giá bán
go
create view V_NGK
as select ngk.MaNGK, ngk.TenNGK, ngk.Quycach, hd.SLKHMua as SoLuongBan, (hd.SLKHMua*hd.DGBan) as TongTien
	from NGK ngk join CT_HOADON hd on ngk.MaNGK= hd.MaNGK
	
--2.Tạo View V_khachang tổng hợp dữ liệu về 10 khách hàng lớn. Danh sách gồm MaKH, TenKH,
--DTKH, Tổng tiền= SoLuongBan*Đơn giá bán 
go
CREATE VIEW V_KHACHHANG AS
SELECT TOP 10 KH.MaKH,KH.TenKH,KH.DTKH,SUM(CT_HOADON.SLKHMua*CT_HOADON.DGBan) AS TONGTIEN
FROM KH JOIN HOADON ON KH.MaKH=HOADON.MaKH JOIN CT_HOADON ON HOADON.SoHD=CT_HOADON.SoHD
GROUP BY KH.MaKH,KH.TenKH,KH.DTKH
ORDER BY SUM(CT_HOADON.SLKHMua*CT_HOADON.DGBan) DESC

-- câu 3:	Tạo view V_TRANO cho biết danh sách khách hàng đã thu hơn 2 lần nhưng chưa trả hết tiền. Danh
-- sách gồm: MaKH, TenKH, DTKH, tổng tiền phải trả, tổng tiền đã trả, số lần thu tiền
go
CREATE VIEW V_SOTIENDATRA
AS
SELECT KH.MaKH,SUM(PHIEUTRANO.SotienTra)AS 'SOTIENTRA',COUNT(PHIEUTRANO.SoHD) AS 'SOLAN'
FROM PHIEUTRANO INNER JOIN HOADON ON  PHIEUTRANO.SoHD=HOADON.SoHD INNER JOIN KH ON KH.MaKH = HOADON.MaKH
GROUP BY KH.MaKH
GO
CREATE VIEW V_SOTIENPHAITRA
AS
SELECT HOADON.MaKH,SUM(DGBan*SLKHMua) AS 'SOTIENPHAITRA'
FROM CT_HOADON JOIN  HOADON ON HOADON.SoHD = CT_HOADON.SoHD
GROUP BY HOADON.MaKH
GO

CREATE VIEW V_TRANO
AS
SELECT KH.MaKH,KH.TenKH,KH.DCKH,SOTIENPHAITRA,SOTIENTRA,SOLAN
FROM KH JOIN V_SOTIENPHAITRA ON V_SOTIENPHAITRA.MaKH = KH.MaKH JOIN V_SOTIENDATRA ON V_SOTIENDATRA.MaKH = KH.MaKH
WHERE V_SOTIENDATRA.SOTIENTRA < V_SOTIENPHAITRA.SOTIENPHAITRA AND V_SOTIENDATRA.SOLAN>2
-- Câu 4: Tạo view V_ngk_ton hiển thị thông tin nước giải khát chưa bán được
go
CREATE VIEW V_ngk_ton as
select * 
from NGK
where not exists (select * from CT_HOADON where NGK.MaNGK=CT_HOADON.MaNGK);

--PROCEDURE
-- câu 1. Tạo thủ tục sp_tong_dt tinh tổng doanh thu của năm (với năm là tham số đầu vào và doanh thu là
--tham số đầu ra)
go
create procedure sp_tong_dt (@year INT , @doanhthu INT output)
as 
begin
select year(hd.NgaylapHD) as nam, sum(cthd.SLKHMua*cthd.DGBan) as doanhthu
from HOADON as hd
join CT_HOADON as cthd on cthd.SoHD = hd.SoHD
where year(hd.NgaylapHD) = @year
group by year(hd.NgaylapHD);
end
--tô đen và execute 2 câu lệnh bên dưới để show bảng kết quả của procedure sp_tong_dt
declare @dt INT
execute sp_tong_dt @year = 2010, @doanhthu = @dt OUTPUT

-- câu 2: Tạo thủ tục sp_danhsach liệt kê n loại nước giải khát bán chạy nhất (doanh thu) trong tháng (với n và tháng là tham số đầu vào)
go
CREATE PROCEDURE sp_danhsach (@n INT, @thang INT)
AS 
SELECT TOP(@n) MaNGK, SUM(SLKHMua*DGBan) AS DOANHTHU
FROM HOADON JOIN CT_HOADON ON HOADON.SoHD = CT_HOADON.SoHD
WHERE MONTH(NgaylapHD) = @thang
GROUP BY MaNGK
ORDER BY DOANHTHU DESC

EXECUTE sp_danhsach @n = 1, @thang= 10

-- Câu 3:.Tạo thủ tục sp_insert_CTPGH nhận vào các tham số tương ứng với thông tin của một dòng trong chi
--	tiết phiếu giao hàng, nếu các điều kiện sau đây được thỏa mãn thì thêm dòng mới tương ứng với các
--	thông tin đã cho vào Table CT_PGH:
--	-SoPGH phải tồn tại trong table PGH
--	-MaNGK ứng với SoDDH phải tồn tại trong table CT_DDH
--	-SLGiao<=SLDAT
--	Thông báo nếu điều kiện trên bị vi phạm
	
go
create procedure sp_insert_CTPGH  @soPGH varchar(5), @MaNGK varchar(3), @SLGiao int, @DGGiao int
as

if @soPGH in (select soPGH from PHIEUGH) 
	and @MaNGK in( select MaNGK from CT_DDH where CT_DDH.SoDDH in 
		( select PHIEUGH.SoDDH from PHIEUGH join CT_PGH
			on PHIEUGH.SoPGH= CT_PGH.SoPGH where CT_PGH.MaNGK=@MaNGK))
	and @SLGiao<=( select SLDat from CT_DDH where CT_DDH.SoDDH in 
		( select PHIEUGH.SoDDH from PHIEUGH join CT_PGH
			on PHIEUGH.SoPGH= CT_PGH.SoPGH where CT_PGH.SoPGH=@soPGH) and CT_DDH.MaNGK=@MaNGK)
begin 
INSERT INTO CT_PGH(SoPGH,MaNGK,SLGiao,DGGiao) values (@soPGH,@MaNGK,@SLGiao,@DGGiao)
print 'insert Thành công'
end
else
print 'insert Lỗi'

go
exec sp_insert_CTPGH @soPGH='PGH01', @MaNGK='SV2',@SLGiao=12, @DGGiao=1000;

--câu 4. Tạo thủ tục có tên sp_delete_CTPH nhận vào các tham số tương ứng với thông tin của một dòng
--trong chi tiết phiếu hẹn, thực hiện các yêu cầu sau:
	--Xóa dòng trương ứng trong chi tiết phiếu hẹn
	--Nếu phiếu hẹn tương ứng không còn dòng chi tiết thì xóa luôn phiếu hẹn đó
go
ALTER PROC SP_DELETE_CTPH @SoPH VARCHAR(20),@MaNGK VARCHAR(20), @SLHen INT
AS
	BEGIN
		IF EXISTS(SELECT 1 FROM CT_PH WHERE SoPH=@SoPH AND MaNGK=@MaNGK AND SLHen=@SLHen)
			BEGIN
				DELETE FROM CT_PH WHERE SoPH=@SoPH AND MaNGK=@MaNGK AND SLHen=@SLHen
				PRINT N'XÓA THÀNH CÔNG CT_PH '+@SoPH +' '+ @MaNGK+' '+CONVERT(varchar(20), @SLHen);
			END
		ELSE
			PRINT N'KHÔNG CÓ CT_PH NÀO ĐƯỢC XÓA';
		IF NOT EXISTS(SELECT 1 FROM CT_PH WHERE SoPH=@SoPH)
			BEGIN
				DELETE FROM PHIEUHEN WHERE SoPH=@SoPH
				PRINT N'XÓA THÀNH CÔNG PH '+ CONVERT(varchar(20), @SoPH);
			END	
	END
GO
EXEC SP_DELETE_CTPH 'PH03','SV2',12

--FUNCTION
--câu 1: Tạo hàm f_list có 2 tham số là @Ngay1 và @Ngay2 cho biết danh sách các NGK đã được bán trong
--khoảng thời gian trên. Danh sách gồm các thuộc tính: MaNGK, TenNGK, DVT, SoLuong.
GO
CREATE FUNCTION f_list (@ngay1 DATE, @ngay2 DATE)
RETURNS TABLE
AS
RETURN(SELECT NGK.TenNGK,NGK.MaNGK,NGK.Quycach AS 'DVT',SUM(CT_DDH.SLDat )AS 'SL'
				FROM CT_DDH JOIN DDH ON CT_DDH.SoDDH = DDH.SoDDH
				JOIN NGK ON CT_DDH.MaNGK = NGK.MaNGK
				WHERE DDH.NgayDH>@ngay1 AND DDH.NgayDH<@ngay2
				GROUP BY  NGK.TenNGK,NGK.MaNGK,NGK.Quycach)
-- Câu 2: Tạo hàm f_max cho biết ĐĐH đã đặt NGK với số lượng nhiều nhất so với các ĐĐH khác có đặt NGK đó. Thông tin hiển thị: SoDDH, MaNGK, [SL đặt nhiều nhất].
go
CREATE FUNCTION f_max()
returns table
as return
SELECT SoDDH, MaNGK, sum(SLDat) "SL dat nhieu nhat"
FROM CT_DDH
GROUP BY SoDDH, MaNGK
HAVING SoDDH in (	SELECT TOP 1 WITH ties SoDDH
					FROM CT_DDH
					WHERE MaNGK = 'CC2'
					GROUP BY SoDDH ORDER BY sum(SLDat) DESC )
--3. Tạo hàm f_kh hiển thị thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất (căn cứ
--vào số lần mua hàng).
GO
CREATE FUNCTION f_kh()
RETURNS TABLE
AS 
RETURN 
SELECT KH.MaKH,KH.TenKH,KH.DTKH,KH.DCKH
FROM KH JOIN HOADON AS HD ON KH.MaKH=HD.MaKH
GROUP BY KH.MaKH,KH.TenKH,KH.DTKH,KH.DCKH
HAVING COUNT(*) >= (SELECT MAX(D.C)
FROM (SELECT COUNT(*) AS C FROM KH AS KH1 JOIN HOADON AS HD1 ON KH1.MaKH=HD1.MaKH  GROUP BY  HD1.MaKH ) AS D)
-- cau4: Tạo hàm f_xlkh nhận vào tham số @MaKH, tính tổng tiền khách hàng đã trả
-- (TongTien=sum(SLKHMua*DGBan)). Sau đó hàm trả về kết quả xếp loại khách hàng như sau:
	-- Nếu TongTien>800.000 : xếp loại “KH VIP”
	-- Nếu TongTien>500.000 : xếp loại “KH THÀNH VIÊN”
	-- Nếu TongTien<=500.000 : xếp loại “KH THÂN THIẾT”
go
CREATE FUNCTION f_xlkh (@MaKH VARCHAR(4))
RETURNS VARCHAR(20)
AS 
BEGIN
DECLARE @result VARCHAR(20), @TongTien INT
SELECT @TongTien = SUM(SLKHMua*DGBan)
FROM HOADON JOIN CT_HOADON ON HOADON.SoHD = CT_HOADON.SoHD
WHERE MaKH = @MaKH
SET @result = CASE 
				WHEN @TongTien < = 500000 THEN  'KH THAN THIET'
				WHEN @TongTien > 500000 AND @TongTien < = 800000 THEN  'KH THANH VIEN'
				ELSE 'KH VIP'
END
RETURN @result
END

DECLARE @ketqua VARCHAR(20)
SET @ketqua = f_xlkh('KH01')
PRINT @ketqua;

SELECT dbo.f_xlkh('KH01') AS tong
PRINT tong
		
--TRIGGER
-- cau1: Tạo trigger PH _insert trên bảng PHIEUHEN kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một dòng vào bảng PHIEUHEN:
	-- MaKH phải tồn tại tron bảng KH
	-- Ngày hẹn giao không thể trước ngày lập phiếu hẹn.
go
CREATE TRIGGER PH_insert 
ON PHIEUHEN FOR INSERT
AS									
IF NOT EXISTS  (SELECT *
				FROM INSERTED JOIN KH ON INSERTED.MaKH = KH.MaKH
				WHERE INSERTED.NgayhenGiao > INSERTED.NgaylapPH)

BEGIN
RAISERROR ('khong the them',10,1)
ROLLBACK
END
DROP TRIGGER PH_insert
INSERT INTO PHIEUHEN VALUES ('PH10', '2014-07-15', '2014-06-15', 'KH03');
SELECT * FROM PHIEUHEN
--câu 2. Tạo trigger CTPH _insert trên bảng CT_PH kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm một
--dòng vào bảng CT_PH:”Tổng số lượng hẹn cho mỗi MaNGK không vượt quá 20”
go
CREATE TRIGGER CTPH_insert ON CT_PH
FOR INSERT
AS 
IF(SELECT C.SLHen FROM CT_PH C JOIN inserted I ON C.MaNGK=I.MaNGK
		WHERE I.SLHen=C.SLHen )>20
BEGIN
	RAISERROR ('TONG SO LUONG PHIEU HEN KHONG THE LON HON 20!',10,1)
	ROLLBACK
END
GO
--TEST
INSERT INTO CT_PH VALUES ('PH03','ST2','19')
GO
SELECT * FROM CT_PH

-- Câu 3:Viết trigger PT_insert trên bảng PHIEUTRANO kiểm tra ràng buộc toàn vẹn sau đây mỗi khi thêm
--một dòng vào bảng PHIEUTRANO:“ Khách hàng chỉ được trả tối đa 3 lần cho mỗi hóa đơn”
		
go
create trigger PT_insert
on PHIEUTRANO 
for insert
as
declare @soLanHen int ;
select  @soLanHen=  count(*) 
	from PHIEUTRANO 
	where SoHD=(select soHD from inserted)
	group by SoHD;
if(@soLanHen>3)
begin 
raiserror ('Khách hàng chỉ được trả tối đa 3 lần cho mỗi hóa đơn',10,1)
rollback
end

go
insert into PHIEUTRANO values('PTN08','02/06/2010','30000','HD01')
--cau 4. Viết trigger HD_update trên bảng HOADON kiểm tra ràng buộc toàn vẹn sau đây mỗi khi cập nhật
--một dòng trên bảng HOADON:
-- Không được cập nhật SoHD
-- MaKH phải tồn tại trong bảng KH
-- NgaylapHD <= Ngày hiện tại
go
CREATE TRIGGER HD_update
ON HOADON FOR UPDATE
AS
IF EXISTS(SELECT * FROM inserted where MaKH not in (SELECT MaKH FROM KH) OR 
NgaylapHD > GETDATE())
OR UPDATE(SOHD)
BEGIN
RAISERROR ('KHONG THE CAP NHAT HOA DON!',10,1)
ROLLBACK TRANSACTION
END






	




