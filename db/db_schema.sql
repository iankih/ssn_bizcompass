-- '팀원' 테이블 생성
CREATE TABLE TeamMembers (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(255),
    Email VARCHAR(255) UNIQUE
);

-- '과업' 테이블 생성
CREATE TABLE Tasks (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    StartDate DATE,
    DueDate DATE,
    Priority ENUM('Low', 'Medium', 'High'),
    Status ENUM('In Progress', 'Completed', 'On Hold'),
    AssigneeID INT,
    FOREIGN KEY (AssigneeID) REFERENCES TeamMembers(MemberID)
);

-- 'Reports' 테이블 생성
CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,  -- 보고서의 고유 ID, 자동 증가
    Title VARCHAR(255) NOT NULL,             -- 보고서의 제목
    Content TEXT NOT NULL,                   -- 보고서의 내용
    CreationDate DATE NOT NULL,              -- 보고서 작성 날짜
    MemberID INT,                            -- 보고서를 작성한 팀원의 ID (TeamMembers 테이블 참조)
    FOREIGN KEY (MemberID) REFERENCES TeamMembers(MemberID) -- 외래키 설정: TeamMembers 테이블의 MemberID 참조
);


-- 'Documents' 테이블 생성
CREATE TABLE Documents (
    DocumentID INT AUTO_INCREMENT PRIMARY KEY, -- 문서의 고유 ID, 자동 증가
    Name VARCHAR(255) NOT NULL,               -- 문서의 이름
    Type VARCHAR(255),                        -- 문서의 유형 (예: 신청서, 요청서 등)
    Path VARCHAR(255) NOT NULL,               -- 문서 파일의 저장 경로
    TaskID INT,                               -- 문서와 관련된 과업의 ID (Tasks 테이블 참조)
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID) -- 외래키 설정: Tasks 테이블의 TaskID 참조
);



