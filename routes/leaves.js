const express = require('express');
const router = express.Router();
const db = require('../database'); // 데이터베이스 연결 가져오기
const verifyToken = require('../middleware/authmiddleware'); // 인증 미들웨어 가져오기

// 휴가 등록 라우트
router.post('/leave', verifyToken, (req, res) => {
    const loggedInUserId = req.user.id;
    const { startDate, endDate, leaveType, reason } = req.body;

    if (!startDate || !endDate || !leaveType || !reason) {
        return res.status(400).send('모든 필드를 올바르게 입력해야 합니다.');
    }

    const insertQuery = 'INSERT INTO Leaves (MemberID, StartDate, EndDate, LeaveType, Reason) VALUES (?, ?, ?, ?, ?)';
    db.query(insertQuery, [loggedInUserId, startDate, endDate, leaveType, reason], (err, results) => {
        if (err) {
            return res.status(500).send('서버 오류');
        }
        res.status(201).send('휴가 등록 성공');
    });
});


// 휴가 조회 라우트
router.get('/leave', verifyToken, (req, res) => {
    const query = 'SELECT * FROM Leaves WHERE MemberID = ?';
    db.query(query, [req.user.id], (err, results) => {
        if (err) {
            return res.status(500).send('서버 오류');
        }
        res.json(results);
    });
});


module.exports = router;
