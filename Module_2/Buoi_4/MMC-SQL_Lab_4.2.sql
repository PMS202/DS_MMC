USE testing_system_db;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
	SELECT `account`.FullName, department.DepartmentName 
	FROM `account`
	LEFT JOIN department
	ON `account`.DepartmentID = department.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
	SELECT * FROM `account` WHERE CreateDate > '2010-12-20';
    
    
-- Question 3: Viết lệnh để lấy ra tất cả các developer
	SELECT `account`.FullName, position.PositionName
	FROM `account`
	LEFT JOIN position
	ON `account`.PositionID = position.PositionID
    WHERE PositionName='Dev';


-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
	SELECT dep.DepartmentName, COUNT(A.DepartmentID)
	FROM department dep
	JOIN `account` A
	ON dep.DepartmentID = A.DepartmentID
    GROUP BY  dep.DepartmentName
    HAVING COUNT(A.DepartmentID)>3;

							
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
	SELECT Q.Content , COUNT(eq.QuestionID)
    FROM question Q
    JOIN examquestion eq
    ON Q.QuestionID = eq.QuestionID
    GROUP BY Q.Content
	ORDER BY COUNT(eq.QuestionID) DESC
    LIMIT 1;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
	SELECT CQ.CategoryName , COUNT(Q.QuestionID)
    FROM categoryquestion as CQ
    JOIN question as Q
    ON CQ.CategoryID = Q.CategoryID
    GROUP BY CQ.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
	SELECT CQ.CategoryName , COUNT(Q.QuestionID)
    FROM categoryquestion as CQ
    JOIN question as Q
    ON CQ.CategoryID = Q.CategoryID
    GROUP BY CQ.CategoryID;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
	SELECT Q.Content , COUNT(Ans.AnswerID)
    FROM question as Q
    JOIN answer as Ans
    ON Q.QuestionID = Ans.QuestionID
    GROUP BY Q.Content
    ORDER BY COUNT(Ans.AnswerID) DESC
    LIMIT 1;


-- Question 9: Thống kê số lượng account trong mỗi group
	SELECT G.GroupName , COUNT( A.AccountID )
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName;

-- Question 10: Tìm chức vụ có ít người nhất
	SELECT P.PositionName
	FROM position as P
	RIGHT JOIN `account` as A
	ON P.PositionID = A.PositionID
	GROUP BY P.PositionName
	ORDER BY COUNT(A.AccountID) ASC
	LIMIT 1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
	SELECT 
    D.DepartmentName , 
    SUM( CASE WHEN A.PositionID = 1 THEN 1 ELSE 0 END ) as DevCount,
    SUM( CASE WHEN A.PositionID = 2 THEN 1 ELSE 0 END ) as TestCount,
    SUM( CASE WHEN A.PositionID = 3 THEN 1 ELSE 0 END ) as ScrumMasterCount,
    COUNT( CASE WHEN A.PositionID = 4 THEN 1 ELSE 0 END ) as PMCount
    FROM department as D
    LEFT JOIN `account` as A
    ON D.DepartmentID = A.DepartmentID
	RIGHT JOIN position as P
    ON A.PositionID = P.PositionID
    GROUP BY D.DepartmentName;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
	SELECT Q.Content, C.CategoryName, T.TypeName, A.FullName, Ans.Content as Answer, Q.CreateDate
    FROM question as Q
    LEFT JOIN categoryquestion as C
    ON Q.CategoryID = C.CategoryID
    LEFT JOIN typequestion as T
    ON Q.TypeID = T.TypeID
    LEFT JOIN `account` as A
    ON Q.CreatorID = A.AccountID
    RIGHT JOIN answer as Ans
    ON Ans.QuestionID = Q.QuestionID;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
	SELECT
    T.TypeName, 
	COUNT(Q.TypeID ) as Count_Question
    FROM typequestion as T
    RIGHT JOIN question as Q
    ON T.TypeID = Q.TypeID
    GROUP BY T.TypeName;

-- Question 14: Lấy ra group không có account nào
	SELECT G.GroupName
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName
    HAVING COUNT( A.AccountID )	= 0;


-- Question 15: Lấy ra group không có account nào
-- Question 16: Lấy ra question không có answer nào
	SELECT
    Q.Content
    FROM question as Q
    RIGHT JOIN answer as Ans
    ON Ans.QuestionID = Q.QuestionID
    GROUP BY Q.Content
    HAVING COUNT( Q.QuestionID ) = 0;
    
    
    
-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
	SELECT *
    FROM `account` as A
    JOIN groupaccount as GA
    ON A.AccountID	= GA.AccountID
    HAVING GA.GroupID =1 ;


-- b) Lấy các account thuộc nhóm thứ 2
	SELECT *
    FROM `account` as A
    JOIN groupaccount as GA
    ON A.AccountID	= GA.AccountID
    HAVING GA.GroupID =2 ;


-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
	SELECT *
    FROM `account` as A
    JOIN groupaccount as GA
    ON A.AccountID	= GA.AccountID
    HAVING GA.GroupID =1 
		UNION
	SELECT *
    FROM `account` as A
    JOIN groupaccount as GA
    ON A.AccountID	= GA.AccountID
    HAVING GA.GroupID =2 ;


-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
	SELECT G.GroupName
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName
    HAVING COUNT( A.AccountID )	> 5;



-- b) Lấy các group có nhỏ hơn 7 thành viên
	SELECT G.GroupName
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName
    HAVING COUNT( A.AccountID )	< 7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
	SELECT G.GroupName
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName
    HAVING COUNT( A.AccountID )	>  5
		UNION ALL
	SELECT G.GroupName
    FROM `group` as G
    LEFT JOIN groupaccount as GA
    ON G.GroupID = GA.GroupID
    RIGHT JOIN `account` as A
    ON GA.AccountID = A.AccountID
    GROUP BY G.GroupName
    HAVING COUNT( A.AccountID )	< 7;
