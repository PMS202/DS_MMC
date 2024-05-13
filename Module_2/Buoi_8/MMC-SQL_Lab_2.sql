DROP DATABASE IF EXISTS Testing_System_Db;
CREATE DATABASE Testing_System_Db;
USE Testing_System_Db;


DROP TABLE IF EXISTS Department;
CREATE TABLE Department (

    DepartmentID        				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName      				NVARCHAR(50) NOT NULL UNIQUE
    
);


DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (

    PositionID          				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName        				ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
    
);


DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (

    AccountID           				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email               				NVARCHAR(50) NOT NULL UNIQUE,
    Username           					NVARCHAR(50) NOT NULL UNIQUE,
    FullName            				NVARCHAR(50) NOT NULL,
    DepartmentID        				TINYINT UNSIGNED,
    PositionID          				TINYINT UNSIGNED,
    CreateDate          				DATETIME DEFAULT NOW(),
    CONSTRAINT fk_department_id			FOREIGN KEY (DepartmentID) 									REFERENCES Department ( DepartmentID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_position_id 			FOREIGN KEY (PositionID) 									REFERENCES Position ( PositionID ) ON DELETE CASCADE ON UPDATE CASCADE
    
);


DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID            					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName           				NVARCHAR(50) NOT NULL UNIQUE,
    CreatorID           				TINYINT UNSIGNED,
    CreateDate        					DATETIME DEFAULT NOW(),
    CONSTRAINT fk_creator_id 			FOREIGN KEY (CreatorID) 									REFERENCES `Account` ( AccountID ) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID            					TINYINT UNSIGNED,
    AccountID          					TINYINT UNSIGNED,
    JoinDate        					DATETIME DEFAULT NOW(),
    PRIMARY KEY 						( GroupID , AccountID ),
    CONSTRAINT fk_group_id 				FOREIGN KEY (GroupID) 										REFERENCES `Group` ( GroupID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_account_id 			FOREIGN KEY (AccountID) 									REFERENCES `Account` ( AccountID ) ON DELETE CASCADE ON UPDATE CASCADE
);	
	
	
DROP TABLE IF EXISTS TypeQuestion;	
CREATE TABLE TypeQuestion (	
    TypeID              				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,	
    TypeName            				ENUM("Essay","Multiple-Choice")	
);	
	
	
DROP TABLE IF EXISTS CategoryQuestion;	
CREATE TABLE CategoryQuestion (	
    CategoryID          				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,	
    CategoryName        				NVARCHAR(50) NOT NULL UNIQUE	
);	
	
	
DROP TABLE IF EXISTS Question;	
CREATE TABLE Question (	
    QuestionID          				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,	
    Content             				NVARCHAR(50) NOT NULL,	
    CategoryID          				TINYINT UNSIGNED,	
    TypeID              				TINYINT UNSIGNED,	
    CreatorID           				TINYINT UNSIGNED,	
    CreateDate         					DATETIME DEFAULT NOW(),	
    CONSTRAINT fk_category_id 			FOREIGN KEY (CategoryID) 									REFERENCES CategoryQuestion ( CategoryID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_type_id 				FOREIGN KEY (TypeID) 										REFERENCES TypeQuestion ( TypeID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_creator_id_ques 		FOREIGN KEY (CreatorID) 									REFERENCES `Account` ( AccountID ) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    AnswerID            				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content             				NVARCHAR(50) NOT NULL,
    QuestionID          				TINYINT UNSIGNED,
    isCorrect          		 			BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_question_id 			FOREIGN KEY ( QuestionID ) 									REFERENCES Question ( QuestionID ) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    ExamID              				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Code                				NVARCHAR(50) NOT NULL UNIQUE,
    Title              					NVARCHAR(50) NOT NULL,
    CategoryID          				TINYINT UNSIGNED,
    Duration            				TINYINT UNSIGNED NOT NULL,
    CreatorID           				TINYINT UNSIGNED,
    CreateDate      					DATETIME DEFAULT NOW(),
	CONSTRAINT fk_category_id_exam 		FOREIGN KEY (CategoryID)									REFERENCES CategoryQuestion ( CategoryID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_creator_id_exam 		FOREIGN KEY (CreatorID) 									REFERENCES `Account` ( AccountID ) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
    ExamID              				TINYINT UNSIGNED,
    QuestionID          				TINYINT UNSIGNED,
    PRIMARY KEY							( ExamID	, QuestionID ),
    CONSTRAINT fk_exam_id 				FOREIGN KEY (ExamID) 										REFERENCES Exam ( ExamID ) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_question_id_ex_ques 	FOREIGN KEY (QuestionID) 									REFERENCES Question ( QuestionID ) ON DELETE CASCADE ON UPDATE CASCADE
    
);


/*============================== INSERT DATABASE =======================================*/

INSERT INTO Department				(	DepartmentName		) 
VALUES
									(	N'Marketing'		),
									(	N'Sale'				),
									(	N'Bảo vệ'			),
									(	N'Nhân sự'			),
									(	N'Kỹ thuật'			),
									(	N'Tài chính'		),
									(	N'Phó giám đốc'		),
									(	N'Giám đốc'			),
									(	N'Thư kí'			),
									(	N'Bán hàng'			);
						
						
INSERT INTO Position				(	PositionName		) 
VALUES 								(	'Dev'				),
									(	'Test'				),
									(	'Scrum Master'		),
									(	'PM'				); 

								
INSERT INTO `Account` 				( 	Email									,	Username					,	FullName					,	DepartmentID		,	PositionID			,	CreateDate 			)
VALUE								(	N'PHUC.DUCHOANG.NGUYEN@yageo,com' 		,	N'PhucNguyen'				,	N'Nguyễn Đức Hoàng Phúc'	,	1					,	1					,	N'2022-01-15'		),
									( 	N'TIEN.QUANGDUONG@yageo.com' 			,	N'TienDuong'				,	N'Dương Quang Tiến'			,	2					,	2					,	N'2022-02-15'		),
									( 	N'HUNG.DOTRI@yageo.com' 				,	N'DoHung'					,	N'Đỗ Trí Hùng'				,	4					,	3					,	N'2011-03-15'		),
									( 	N'AN.TRUONGNGUYEN@yageo.com' 			,	N'AnNguyen'					,	N'Nguyễn Trường An'			,	3					,	4					,	N'2021-04-15'		),
									( 	N'DA.VANLE@yageo.com' 					,	N'DaLe'						,	N'Lê Văn Đá'				,	5					,	1					,	N'2017-05-15'		),
									( 	N'THACH.CHINGUYEN@yageo.com' 			,	N'Thach'					,	N'Nguyễn Chí Thạch'			,	8					,	2					,	N'2015-06-15'		),
									( 	N'THIEN.MINHNGUYEN@yageo.com' 			,	N'Thien'					,	N'Nguyễn Minh Thiện'		,	9					,	3					,	N'2006-07-15'		),
									( 	N'TRANG.THUYPHAM@yageo.com' 			,	N'TRANG'					,	N'Phạm Thùy Trang'			,	6					,	4					,	N'1999-08-15'		),
									( 	N'HAN.LEVAN@yageo.com' 					,	N'HAN'						,	N'Lê Văn Hân'				,	7					,	1					,	N'2000-09-15'		),
									( 	N'CAN.HUYNH@yageo.com' 					,	N'CAN'						,	N'Huỳnh Cẩn'				,	10					,	2					,	N'2007-10-15'		);
							
							
INSERT INTO `Group`					(  GroupName			, CreatorID		, CreateDate)
VALUES 								(N'Testing System'		,   5			,'2019-03-05'),
									(N'Development'			,   1			,'2020-03-07'),
									(N'VTI Sale 01'			,   2			,'2020-03-09'),
									(N'VTI Sale 02'			,   3			,'2020-03-10'),
									(N'VTI Sale 03'			,   4			,'2020-03-28'),
									(N'VTI Creator'			,   6			,'2020-04-06'),
									(N'VTI Marketing 01'	,   7			,'2020-04-07'),
									(N'Management'			,   8			,'2020-04-08'),
									(N'Chat with love'		,   9			,'2020-04-09'),
									(N'Vi Ti Ai'			,   10			,'2020-04-10');
		
-- Add data GroupAccount		
INSERT INTO `GroupAccount`			(  GroupID	, AccountID	, JoinDate	 )
VALUES 								(	1		,    1		,'2019-03-05'),
									(	1		,    2		,'2020-03-07'),
									(	3		,    3		,'2020-03-09'),
									(	3		,    4		,'2020-03-10'),
									(	5		,    5		,'2020-03-28'),
									(	1		,    3		,'2020-04-06'),
									(	1		,    7		,'2020-04-07'),
									(	8		,    3		,'2020-04-08'),
									(	1		,    9		,'2020-04-09'),
									(	10		,    10		,'2020-04-10');
		
		
-- Add data TypeQuestion		
INSERT INTO TypeQuestion			(TypeName			) 
VALUES 								('Essay'			), 
									('Multiple-Choice'	); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Add data Question
INSERT INTO Question				(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 								(N'Câu hỏi về Java'	,	1		,   '1'			,   '2'		,'2020-04-05'),
									(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
									(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
									(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
									(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
									(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
									(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
									(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
									(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
									(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer					(  Content		, QuestionID	, isCorrect	)
VALUES 								(N'Trả lời 01'	,   1			,	0		),
									(N'Trả lời 02'	,   1			,	1		),
									(N'Trả lời 03'	,   1			,	0		),
									(N'Trả lời 04'	,   1			,	1		),
									(N'Trả lời 05'	,   2			,	1		),
									(N'Trả lời 06'	,   3			,	1		),
									(N'Trả lời 07'	,   4			,	0		),
									(N'Trả lời 08'	,   8			,	0		),
									(N'Trả lời 09'	,   9			,	1		),
									(N'Trả lời 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam					(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 								('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
									('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
									('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
									('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
									('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
									('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
									('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
									('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
									('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
									('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion			(ExamID	, QuestionID	) 
VALUES 								(	1	,		5		),
									(	2	,		10		), 
									(	3	,		4		), 
									(	4	,		3		), 
									(	5	,		7		), 
									(	6	,		10		), 
									(	7	,		2		), 
									(	8	,		10		), 
									(	9	,		9		), 
									(	10	,		8		); 


