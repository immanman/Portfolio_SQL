
use Quanligiaovu;
go
--CAU 1 : Cho biết danh sách các khoa được thành lập trong 6 tháng cuối năm 2005
SELECT *
FROM KHOA
WHERE NGTLAP>31/05/2005 AND YEAR(NGTLAP)<2006 ;
GO
--CAU 2: Cho biết danh sách các khoa chưa có trưởng khoa
SELECT *
FROM KHOA
WHERE TRGKHOA= 'NULL';
GO
--CAU 3: Cho biết danh sách các khoa có tên khoa bắt đầu bởi ký tự ‘k’ và kết thúc bởi ký tự ‘h’
SELECT *
FROM KHOA
WHERE TENKHOA LIKE'K%H';
GO
--CAU 4: Cho biết danh sách các khoa được thành lập sớm nhất
SELECT *
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP) FROM KHOA);
GO
--CAU 5: Cho biết danh sách giáo viên có mức lương thấp nhất
SELECT *
FROM GIAOVIEN
WHERE MUCLUONG = (SELECT MIN(MUCLUONG) FROM GIAOVIEN);
GO
--CAU 6: Cho biết danh sách giáo viên có hoc vị tiến sĩ và nhỏ hơn 50 tuổi
SELECT *
FROM GIAOVIEN
WHERE HOCVI='TS' AND YEAR(GETDATE())-YEAR( NGSINH)<50;
GO
--CAU 7: Cho biết danh sách giáo viên nam có mức lương >1800000
SELECT *
FROM GIAOVIEN
WHERE GIOITINH='Nam' AND MUCLUONG>1800000;
GO
--CAU 8: Cho biết danh sách giáo viên lớn tuổi nhất
SELECT *
FROM GIAOVIEN
WHERE (year(GETDATE())-year(NGSINH)) =(SELECT max (year(getdate())- year(NGSINH))FROM GIAOVIEN);
GO
--CAU 9: Cho biết danh sách học viên nữ, sinh tại Vĩnh long và lớn hơn 30 tuổi
SELECT *
FROM HOCVIEN
WHERE GIOITINH='Nu' AND NOISINH='Vinh Long' AND YEAR(NGSINH)>30;
go
-- CAU33: Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất
SELECT hv.MAHV,HO,TEN 
FROM HOCVIEN hv join KETQUATHI kqt on hv.MAHV=kqt.MAHV
WHERE hv.MAHV=kqt.MAHV AND kqt.DIEM in (9,10) AND hv.MALOP like 'k1_';
go
--cau34: Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
select gv.MAGV,gd.NAM, gd.HOCKY ,COUNT(gd.MAMH)soMonHoc,count(gd.MALOP)solop
from GIAOVIEN gv join GIANGDAY gd on gv.MAGV= gd.MAGV
where gd.NAM like '200_' and gd.HOCKY like '_'
group by gv.MAGV ,gd.NAM,  gd.HOCKY;
go 
--cau35: Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất
select gd.NAM, gd.HOCKY, gv.MAGV ,gv.HOTEN , count (gd.MAGV)soLanday
from GIAOVIEN gv join GIANGDAY gd on gv.MAGV = gd.MAGV
where gd.NAM like '200_' and gd.HOCKY like '_' 
group by gd.NAM, gd.HOCKY, gv.MAGV ,gv.HOTEN 
having count(gd.MAGV)>=all (select count(gd1.MAGV)
							from GIANGDAY gd1 
							group by gd1.NAM, gd1.HOCKY, gd1.MAGV )
go
-- cau36: Thống kê số lượng các môn thi theo từng học kỳ,từng năm
SELECT gd.HOCKY,gd.NAM, COUNT( DISTINCT gd.MAMH) SoLuongMon
FROM GIANGDAY gd
GROUP BY gd.HOCKY,gd.NAM
go
--cau37: Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
select kqt.MAMH,mh.TENMH,COUNT(kqt.MAMH)soLuong
from KETQUATHI kqt join MONHOC mh on kqt.MAMH = mh.MAMH
where kqt.LANTHI=1 and kqt.KQUA='Khong Dat'
group by kqt.MAMH,mh.TENMH
having COUNT(kqt.MAMH)>=all (select COUNT(kqt1.MAMH)
									from KETQUATHI kqt1 
									where kqt1.LANTHI=1 and kqt1.KQUA='Khong Dat'
									group by kqt1.MAMH)
go
-- cau38: Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
select kqt.MAHV, hv.HO, hv.TEN
from HOCVIEN hv join KETQUATHI kqt on hv.MAHV=kqt.MAHV
where kqt.LANTHI=1 and kqt.KQUA='Dat'
group by  kqt.MAHV, hv.HO, hv.TEN
HAVING COUNT(kqt.MAMH)>=all (SELECT COUNT(kqt1.MAMH)
							 FROM KETQUATHI kqt1
							 WHERE kqt1.LANTHI=1 AND kqt1.KQUA='Dat'
							 GROUP BY  kqt1.MAHV)
go
-- cau39: Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
select kqt.MAHV, hv.HO, hv.TEN, max (kqt.LANTHI) LanThiCuoi
from HOCVIEN hv join KETQUATHI kqt on hv.MAHV=kqt.MAHV
where  kqt.KQUA='Dat'
group by  kqt.MAHV, hv.HO, hv.TEN
HAVING max (kqt.LANTHI)>= all (SELECT max(kqt2.LANTHI)
							 FROM KETQUATHI kqt2
							 GROUP BY  kqt2.MAHV)
go
-- cau 40:  Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
select kqt.MAHV, hv.HO,hv.TEN,kqt.MAMH,  max(kqt.DIEM) MaxDIEM
from HOCVIEN hv join KETQUATHI kqt on hv.MAHV=kqt.MAHV
group by kqt.MAHV, hv.HO,hv.TEN,kqt.MAMH
HAVING max (kqt.DIEM)>= all (SELECT max(kqt2.DIEM)
							 FROM KETQUATHI kqt2
							 GROUP BY  kqt2.MAHV)
go
--10: Cho biết danh sách học viên nhỏ tuổi nhất
SELECT *
FROM  HOCVIEN
WHERE (year(GETDATE())-year(NGSINH)) = (SELECT MIN((year(GETDATE())-year(NGSINH))) FROM  HOCVIEN)
--11 : In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp
SELECT  HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, HOCVIEN.NGSINH, HOCVIEN.MALOP 
FROM HOCVIEN ,LOP 
WHERE HOCVIEN.MAHV = LOP.TRGLOP
--12:  In ra điểm thi môn CSDL (mã học viên, họ tên , lần thi, điểm số) sắp xếp theo tên, họ học viên.
SELECT HV.MAHV ,HV.HO,HV.TEN ,KQT.LANTHI,KQT.DIEM
FROM  HOCVIEN HV JOIN   KETQUATHI KQT ON KQT.MAHV = HV.MAHV
WHERE KQT.MAMH='CSDL'
ORDER BY HV.TEN , HV.HO;
--13: In danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT KQ.MAHV, KQ.MAMH, KQ.LANTHI, KQUA
FROM  KETQUATHI AS KQ
 WHERE KQ.LANTHI = (SELECT MAX(LANTHI)AS LANTHI 
					FROM  KETQUATHI AS KQ1
					WHERE KQ1.MAHV = KQ.MAHV AND KQ1.MAMH = KQ.MAMH AND KQ.MAMH='CSDL')

--14: In Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi)
SELECT KQT.MAHV, KQT.MAMH, KQT.DIEM, KQT.LANTHI 
FROM  KETQUATHI AS KQT 
WHERE KQT.DIEM=(SELECT MAX(DIEM) 
				FROM  KETQUATHI AS KETQUA 
				WHERE KQT.MAHV= KETQUA.MAHV AND KETQUA.MAMH='CSDL' AND KQT.MAMH='CSDL')


--15: In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, MONHOC.TENMH
FROM HOCVIEN JOIN  KETQUATHI ON HOCVIEN.MAHV =  KETQUATHI.MAHV
JOIN MONHOC ON  KETQUATHI.MAMH = MONHOC.MAMH
WHERE LANTHI = 1 AND KQUA='Dat';

--16: In ra danh sách học viên (mã học viên, họ tên) thi môn CTRR không đạt (ở lần thi 1)
SELECT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN JOIN  KETQUATHI ON HOCVIEN.MAHV =  KETQUATHI.MAHV
WHERE LANTHI = 1 AND KQUA='Khong dat' AND  KETQUATHI.MAMH = 'CTRR';

--17: Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT MONHOC.TENMH
FROM MONHOC
JOIN GIANGDAY ON GIANGDAY.MAMH = MONHOC.MAMH
JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
WHERE GIAOVIEN.HOTEN = 'Tran Tam Thanh' AND GIANGDAY.HOCKY = 1 AND GIANGDAY.NAM=2006;

--18: Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT MONHOC.MAMH, MONHOC.TENMH
FROM MONHOC
JOIN GIANGDAY ON GIANGDAY.MAMH = MONHOC.MAMH
JOIN LOP ON LOP.MAGVCN = GIANGDAY.MAGV
WHERE LOP.MALOP='K11' AND GIANGDAY.HOCKY = 1 AND GIANGDAY.NAM=2006;

--19: Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
JOIN LOP ON LOP.TRGLOP = HOCVIEN.MAHV
JOIN GIANGDAY ON LOP.MALOP = GIANGDAY.MALOP
JOIN GIAOVIEN ON GIANGDAY.MAGV = GIAOVIEN.MAGV
JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
WHERE GIAOVIEN.HOTEN = 'Nguyen To Lan' AND MONHOC.TENMH = 'Co So Du Lieu';
 --C2:
SELECT HOCVIEN.HO, HOCVIEN.TEN
FROM HOCVIEN
JOIN LOP ON LOP.TRGLOP = HOCVIEN.MAHV
JOIN GIANGDAY ON LOP.MALOP = GIANGDAY.MALOP
WHERE GIANGDAY.MAMH IN (SELECT MAMH FROM MONHOC WHERE  MONHOC.TENMH = 'Co So Du Lieu')
AND GIANGDAY.MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE  GIAOVIEN.HOTEN = 'Nguyen To Lan');
--20: In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT  MONHOC.MAMH,  MONHOC.TENMH
FROM  MONHOC JOIN  DIEUKIEN ON DIEUKIEN.MAMH_TRUOC = MONHOC.MAMH
WHERE  DIEUKIEN.MAMH='CSDL'
--21: Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT  DIEUKIEN.MAMH,  MONHOC.TENMH
FROM  MONHOC JOIN  DIEUKIEN ON DIEUKIEN.MAMH = MONHOC.MAMH
WHERE  DIEUKIEN.MAMH_TRUOC='CTRR'
--22: Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT  GIAOVIEN.HOTEN
FROM  GIAOVIEN JOIN  GIANGDAY ON GIANGDAY.MAGV = GIAOVIEN.MAGV JOIN 
        (SELECT  GIANGDAY.MAGV FROM  GIANGDAY WHERE  GIANGDAY.MALOP='K12') AS DAY_K12 ON DAY_K12.MAGV = GIANGDAY.MAGV
WHERE  GIANGDAY.MAMH='CTRR' AND  GIANGDAY.HOCKY=1 AND  GIANGDAY.NAM=2006 
AND  GIANGDAY.MALOP='K11' 

--23: Thống kê số lượng học viên của từng lớp. Danh sách gồm: mã lớp, tên lớp, số lượng học viên. sắp xếp theo số lượng giảm dần
SELECT  LOP.MALOP ,  LOP.TENLOP,  LOP.SISO
FROM  LOP 
ORDER BY  LOP.SISO DESC
--24:  Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT   GIAOVIEN.HOCVI, COUNT( GIAOVIEN.HOCVI)  SOLUONG
FROM  GIAOVIEN
GROUP BY   GIAOVIEN.HOCVI
--25: Thống kê số lượng giáo viên theo độ tuổi.
		--Cao tuổi: trên 60 tuổi
		--Trung niên: từ 40 đến 60 tuổi
		--Trẻ : dưới 40 tuổi
SELECT TUOI_GIAOVIEN.DO_TUOI,COUNT(TUOI_GIAOVIEN.MAGV) AS SOLUONGGV
FROM  GIAOVIEN JOIN
 (SELECT  GIAOVIEN.MAGV,  GIAOVIEN.HOTEN,
  CASE 
      WHEN YEAR(GETDATE()) - YEAR(NGSINH) >  60  THEN 'CAO TUOI'
      WHEN YEAR(GETDATE()) - YEAR(NGSINH) >40 AND YEAR(GETDATE()) - YEAR(NGSINH) <=60 THEN 'TRUNG NIEN'
      ELSE 'TRE'
      END  DO_TUOI
   FROM	 GIAOVIEN) AS TUOI_GIAOVIEN ON TUOI_GIAOVIEN.MAGV = GIAOVIEN.MAGV
GROUP BY  TUOI_GIAOVIEN.DO_TUOI
go
--cau 26 Mỗi môn học thông kê số lượng học viên theo kết quả (đạt và không đạt).
select MAMH, KQUA, COUNT(*) KQ_COUNT
from KETQUATHI
GROUP BY MAMH, KQUA;

--CAU 27 Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT GIAOVIEN.MAGV, GIAOVIEN.HOTEN
FROM GIAOVIEN
WHERE MAGV IN (
SELECT MAGV
FROM GIANGDAY
WHERE MAGV IN (SELECT LOP.MAGVCN FROM LOP)
GROUP BY MAGV, MALOP
HAVING COUNT(*) >=1 );

--CAU 28: Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
SELECT GIAOVIEN.MAGV, GIAOVIEN.HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (SELECT GIANGDAY.MAGV FROM GIANGDAY);

--CAU 29:  Tìm giáo viên (mã giáo viên, họ tên) đã dạy hết tất cả các môn học của khoa quản lý
SELECT gv.MAGV, gv.HOTEN	
FROM KHOA k join GIAOVIEN gv ON k.MAKHOA = gv.MAKHOA 
WHERE k.MAKHOA = gv.MAKHOA;

--CAU 30:  Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất
SELECT hv.HO, hv.TEN
FROM HOCVIEN hv join LOP lop ON hv.MALOP = lop.MALOP
WHERE hv.MAHV = lop.TRGLOP AND lop.SISO = (SELECT MAX(SISO) FROM LOP);

--CAU 31 Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi)
SELECT A.HO,A.TEN 
FROM HOCVIEN A JOIN LOP lop ON A.MAHV=lop.TRGLOP
	 JOIN (SELECT kqt.MAHV,kqt.MAMH,kqt.KQUA FROM KETQUATHI kqt
	 WHERE kqt.KQUA='Khong Dat' 
	 GROUP BY kqt.MAHV,kqt.MAMH,kqt.KQUA 
	 HAVING COUNT(kqt.MAMH)=COUNT(kqt.KQUA)) as B ON B.MAHV =A.MAHV
GROUP BY A.HO, A.TEN 
HAVING COUNT(*)>=3;

--CAU 32 Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT A.HO, A.TEN
FROM HOCVIEN A
WHERE A.MAHV IN (SELECT kqt.MAHV 
	FROM KETQUATHI kqt 
	WHERE kqt.DIEM >=9
	GROUP BY kqt.MAHV
	HAVING COUNT(*) >= ALL(SELECT COUNT(*) diem
							FROM KETQUATHI
							WHERE KETQUATHI.DIEM >=9
							GROUP BY KETQUATHI.MAHV));