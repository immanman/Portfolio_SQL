use QLGiaoVu;

-- Câu 13: Cho biết giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT GIAOVIEN.MAGV, GIAOVIEN.HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (SELECT GIANGDAY.MAGV FROM GIANGDAY);

-- Câu 14: Cho biết giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN AS GV JOIN GIANGDAY ON GV.MAGV = GIANGDAY.MAGV
					JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
WHERE GV.MAKHOA = MONHOC.MAKHOA
GROUP BY GV.MAGV, GV.HOTEN, GV.MAKHOA
HAVING COUNT (DISTINCT GIANGDAY.MAMH) = (SELECT COUNT(MONHOC.MAMH)
										FROM MONHOC
										WHERE  NOT IN MONHOC.MAKHOA = GV.MAKHOA);

-- Câu 15: Cho biết họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.


-- Câu 16: Cho biết họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT GIAOVIEN.HOTEN
FROM GIAOVIEN JOIN GIANGDAY ON GIANGDAY.MAGV = GIAOVIEN.MAGV JOIN 
        (SELECT GIANGDAY.MAGV FROM GIANGDAY WHERE GIANGDAY.MALOP='K12') AS DAY_K12 ON DAY_K12.MAGV = GIANGDAY.MAGV
WHERE GIANGDAY.MAMH='CTRR' AND GIANGDAY.HOCKY=1 AND GIANGDAY.NAM=2006 
AND GIANGDAY.MALOP='K11' ;

-- Câu 17: Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT KQ.MAHV, KQ.MAMH, KQ.LANTHI, KQUA
FROM KETQUATHI AS KQ
 WHERE KQ.LANTHI = (SELECT MAX(LANTHI)AS LANTHI 
					FROM KETQUATHI AS KQ1
					WHERE KQ1.MAHV = KQ.MAHV AND KQ1.MAMH = KQ.MAMH AND KQ.MAMH='CSDL');
-- Câu 18: Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT KQT.MAHV, KQT.MAMH, KQT.DIEM, KQT.LANTHI 
FROM KETQUATHI AS KQT 
WHERE KQT.DIEM=(SELECT MAX(DIEM) 
									FROM KETQUATHI AS KETQUA 
									WHERE KQT.MAHV= KETQUA.MAHV AND KETQUA.MAMH='CSDL' AND KQT.MAMH='CSDL');

-- Câu 19: Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
 SELECT MAKHOA, TENKHOA
 FROM  KHOA
 WHERE NGTLAP =(SELECT MIN(NGTLAP)  FROM  KHOA); 

 -- Câu 20: Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT   GIAOVIEN.HOCHAM, COUNT(GIAOVIEN.HOCHAM)  SOLUONG
FROM  GIAOVIEN
WHERE GIAOVIEN.HOCHAM='GS' and GIAOVIEN.HOCHAM='PGS'

