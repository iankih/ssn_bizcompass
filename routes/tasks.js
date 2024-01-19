const express = require('express');
const router = express.Router();
const db = require('../database'); // 데이터베이스 연결 가져오기
const verifyToken = require('../middleware/authmiddleware'); // 인증 미들웨어 가져오기

router.use(express.json()); // 요청 본문 파싱

// 과업 등록 라우트 (모든 사용자가 접근 가능)
router.post('/', verifyToken, (req, res) => {
  const loggedInUserId = req.user.id;
  const { taskName, startDate, dueDate, requester, taskType, priority, description, status } = req.body;

  if (!taskName || !startDate || !dueDate || !requester || !taskType || !priority || !description || !status) {
      return res.status(400).send('모든 필드를 올바르게 입력해야 합니다.');
  }

  const currentDate = new Date(); // 현재 시간
  const insertQuery = 'INSERT INTO Tasks (MemberID, TaskName, StartDate, DueDate, Requester, TaskType, Priority, Description, Status, CreatedDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  const values = [loggedInUserId, taskName, startDate, dueDate, requester, taskType, priority, description, status, currentDate];

  db.query(insertQuery, values, (err, results) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      res.status(201).send('과업 등록 성공');
  });
});


// 사용자 자신의 과업 조회 라우트
router.get('/my', verifyToken, (req, res) => {
  const loggedInUserId = req.user.id;
  let query = 'SELECT * FROM Tasks WHERE MemberID = ?';
  const queryParams = [loggedInUserId];

  const { status } = req.query;
  if (status) {
      query += ' AND Status = ?';
      queryParams.push(status);
  }

  db.query(query, queryParams, (err, results) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      res.json(results);
  });
});

// 과업 수정 라우트
router.put('/update/:taskId', verifyToken, (req, res) => {
  const taskId = req.params.taskId;
  const updatedData = req.body; // 변경된 데이터

  const updatedDate = new Date(); // 현재 시간
  // 과업 수정 이력을 TaskHistory에 저장
  const historyQuery = 'INSERT INTO TaskHistory (TaskID, UpdatedData, UpdateDate) VALUES (?, ?, ?)';
  db.query(historyQuery, [taskId, JSON.stringify(updatedData), updatedDate], (err, results) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      res.status(200).send('과업 수정 이력 추가 성공');
  });
});


// 관리자 여부 확인을 위한 함수 (예시)
function isAdmin(userId, callback) {
  // 여기서는 데이터베이스에서 userId에 해당하는 사용자의 역할을 확인
  // 예를 들어, User 테이블에 Role 필드가 있다고 가정
  db.query('SELECT Role FROM Users WHERE UserID = ?', [userId], (err, results) => {
      if (err) {
          return callback(err, null);
      }
      const isUserAdmin = results[0] && results[0].Role === 'admin';
      callback(null, isUserAdmin);
  });
}

// 관리자용 사용자 목록 조회 라우트
router.get('/users', verifyToken, (req, res) => {
  const loggedInUserId = req.user.id;

  // 관리자 여부 확인
  isAdmin(loggedInUserId, (err, isUserAdmin) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      if (!isUserAdmin) {
          return res.status(403).send('권한 없음');
      }

      const query = 'SELECT MemberID, Name FROM TeamMembers';
      db.query(query, (err, results) => {
          if (err) {
              return res.status(500).send('서버 오류');
          }
          res.json(results);
      });
  });
});


// 관리자용 특정 팀원 과업 조회 라우트
router.get('/member/:memberId', verifyToken, (req, res) => {
  const memberId = req.params.memberId;
  const loggedInUserId = req.user.id;

  // 관리자 여부 확인
  isAdmin(loggedInUserId, (err, isUserAdmin) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      if (!isUserAdmin) {
          return res.status(403).send('권한 없음');
      }

      // Tasks 테이블과 TeamMembers 테이블 조인하여 과업과 팀원 이름 조회
      const query = `
          SELECT Tasks.*, TeamMembers.Name 
          FROM Tasks 
          INNER JOIN TeamMembers ON Tasks.MemberID = TeamMembers.MemberID 
          WHERE Tasks.MemberID = ?
      `;
      db.query(query, [memberId], (err, results) => {
          if (err) {
              return res.status(500).send('서버 오류');
          }
          res.json(results);
      });
  });
});


// 과업 히스토리 조회 라우트
router.get('/history/:taskId', verifyToken, (req, res) => {
  const taskId = req.params.taskId;

  const query = 'SELECT * FROM TaskHistory WHERE TaskID = ? ORDER BY UpdateDate DESC';
  db.query(query, [taskId], (err, results) => {
      if (err) {
          return res.status(500).send('서버 오류');
      }
      res.json(results);
  });
});



module.exports = router;
