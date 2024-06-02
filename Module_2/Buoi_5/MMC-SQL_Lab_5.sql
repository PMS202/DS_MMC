USE testing_system_db;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
	DROP VIEW IF EXISTS vw_NhanVienPhongSale;
	CREATE VIEW vw_NhanVienPhongSale AS
										(
											SELECT A.* 
											FROM `account` AS A
											LEFT JOIN department AS D
											ON A.DepartmentID = D.DepartmentID
											WHERE D.DepartmentName = 'Sale' );
	
	
	SELECT * FROM vw_NhanVienPhongSale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
	DROP VIEW IF EXISTS vw_ThongTinAccount;
	CREATE VIEW 	vw_ThongTinAccount AS
	WITH 			CTE_DanhSachSoLuongAccount AS
													(
														SELECT 		COUNT(GA.AccountID) AS countGA
														FROM		GroupAccount GA
														GROUP BY	GA.AccountID
													)
	
	SELECT			A.AccountID, A.Username, COUNT(GA.AccountID) AS SL 
	FROM			GroupAccount GA
	INNER JOIN		`account` A
	ON				GA.AccountID = A.AccountID
	GROUP BY		GA.AccountID
	HAVING			COUNT(GA.AccountID) = ( SELECT MAX(countGA) AS maxCount FROM CTE_DanhSachSoLuongAccount);
	
	SELECT * FROM vw_ThongTinAccount;


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
	DROP VIEW IF EXISTS vw_CauHoiDai;
	CREATE VIEW vw_CauHoiDai AS
										(
											SELECT Q.* 
											FROM question AS Q
											WHERE LENGTH(Q.Content) > 20 );
	
	
	SELECT * FROM vw_CauHoiDai;
    
	CREATE TEMPORARY TABLE temp AS SELECT * FROM vw_CauHoiDai;
    
    DELETE FROM question AS Q
    WHERE Q.QuestionID IN ( SELECT QuestionID FROM temp ) ;
    
	DROP TEMPORARY TABLE temp;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
	DROP VIEW IF EXISTS vw_Most_staff_department;
	CREATE VIEW 	vw_Most_staff_department AS
        WITH CTE_Count_Staff  AS
							(	
								SELECT COUNT(A.DepartmentID) AS Count_Staff
                                FROM `account` AS A
                                GROUP BY A.DepartmentID
                                )
		SELECT			D.DepartmentID , D.DepartmentName , COUNT( A.AccountID )
		FROM			department D
		INNER JOIN		`account` A
		ON				D.DepartmentID = A.DepartmentID
		GROUP BY		D.DepartmentName
		HAVING			COUNT(A.AccountID) = ( SELECT MAX(Count_Staff) FROM CTE_Count_Staff);
        
	SELECT * FROM vw_most_staff_department;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
	DROP VIEW IF EXISTS vw_Nguyen_Question;
	CREATE VIEW 	vw_Nguyen_Question AS
		SELECT			Q.*
		FROM			question Q
		INNER JOIN		`account` A
		ON				Q.CreatorID = A.AccountID
		WHERE			A.FullName LIKE 'Nguyễn%';
        
	SELECT * FROM vw_Nguyen_Question;
