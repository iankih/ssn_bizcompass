
-- 'TeamMembers' 테이블 (변경 없음)
CREATE TABLE TeamMembers (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(255),
    Email VARCHAR(255) UNIQUE
);

-- 'Tasks' 테이블 수정
CREATE TABLE Tasks (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    StartDate DATE,
    DueDate DATE,
    Requester VARCHAR(255),
    TaskType VARCHAR(50),
    Priority VARCHAR(50),
    Description TEXT,
    FOREIGN KEY (MemberID) REFERENCES TeamMembers(MemberID)
);

-- 'Reports' 테이블 생성
CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    SubmissionDate DATE,
    ReportContent TEXT,
    FOREIGN KEY (MemberID) REFERENCES TeamMembers(MemberID)
);

-- 'Documents' 테이블 생성
CREATE TABLE Documents (
    DocumentID INT AUTO_INCREMENT PRIMARY KEY,
    TaskID INT,
    DocumentName VARCHAR(255),
    DocumentPath TEXT,
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID)
);

-- 'TaskHistory' 테이블 생성
CREATE TABLE TaskHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    TaskID INT,
    UpdateDate DATE,
    Status VARCHAR(100),
    Comments TEXT,
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID)
);

-- 'Leave' 테이블 생성
CREATE TABLE `Leave` (
    LeaveID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    LeaveDate DATE,
    LeaveType VARCHAR(100),
    Reason TEXT,
    FOREIGN KEY (MemberID) REFERENCES TeamMembers(MemberID)
);

-- 'USERS' 테이블 생성
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(255)
);
