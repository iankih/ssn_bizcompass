const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/authmiddleware');

// 보호된 라우트 예시
router.get('/dashboard', verifyToken, (req, res) => {
    // 이 라우트는 유효한 JWT 토큰이 있는 사용자만 접근 가능
    res.json({ message: "Welcome to the protected dashboard!" });
});

module.exports = router;
