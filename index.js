const express = require('express');
const app = express();
const tasksRouter = require('./routes/tasks'); // 별도 모듈로 분리한 라우트 가져오기

const PORT = process.env.PORT || 3000;

// 루트 라우트
app.get('/', (req, res) => {
  res.send('안녕하세요, SSN Project!');
});

// 다른 라우트들을 '/api' 경로 아래에 연결
app.use('/api', tasksRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
