const express = require('express');
const router = express.Router();

// body-parser 미들웨어를 사용해 요청 본문을 파싱합니다.
// Express 4.16.0 이상에서는 express.json() 미들웨어를 사용할 수 있습니다.
router.use(express.json());

router.post('/tasks', (req, res) => {
    // 요청 본문에서 데이터 추출
    const { startDate, dueDate, requester, taskType, priority, description } = req.body;

    // 데이터 유효성 검사
    // 예: 각 필드가 비어있지 않은지, 날짜가 올바른 형식인지 등
    // 유효하지 않은 경우, 에러 메시지와 함께 응답을 반환
    if (!startDate || !dueDate || !requester || !taskType || !priority || !description) {
        return res.status(400).send('모든 필드를 올바르게 입력해야 합니다.');
    }

    // 과업 데이터를 데이터베이스에 저장하는 로직
    // 예: MongoDB, MySQL 등을 사용하여 데이터 저장
    // 데이터베이스 저장 성공 시 응답 반환
    res.status(201).send('과업이 성공적으로 등록되었습니다.');
});

module.exports = router;
