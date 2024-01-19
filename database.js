// C:\ssn\database.js
// MySQL 연결 설정
require('dotenv').config();
const mysql = require('mysql');

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE
});

connection.connect(err => {
  if (err) {
    console.error('데이터베이스 연결 실패: ' + err.stack);
    return;
  }
  console.log('데이터베이스에 성공적으로 연결되었습니다.');
});

module.exports = connection;
