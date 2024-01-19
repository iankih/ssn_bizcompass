const express = require('express');
const app = express();
const tasksRouter = require('./routes/tasks');
const authRouter = require('./routes/auth');
const protectedRoutes = require('./routes/protectedRoutes');
const verifyToken = require('./middleware/authmiddleware');

const PORT = process.env.PORT || 3000;

// 미들웨어 설정
app.use(express.json()); // JSON 요청 본문 처리

// 루트 라우트
app.get('/', (req, res) => {
  res.send('안녕하세요, SSN Project!');
});

// 회원가입 및 로그인 라우트
app.use('/api/auth', authRouter);

// 과업 관련 라우트
app.use('/api/tasks', tasksRouter);

// 인증이 필요한 라우트
app.use('/api/protected', verifyToken, protectedRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
