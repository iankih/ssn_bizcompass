const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const router = express.Router();
const db = require('../database'); // 데이터베이스 연결 모듈

// 환경 변수에서 JWT 비밀 키 가져오기
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key';

// 회원가입 라우트
router.post('/signup', async (req, res) => {
    const { name, email, phoneNumber, position, password } = req.body;
    if (!name || !email || !phoneNumber || !position || !password) {
        return res.status(400).send('All fields are required.');
    }

    // 이메일이 이미 존재하는지 확인
    const emailExistsQuery = 'SELECT * FROM TeamMembers WHERE Email = ?';
    db.query(emailExistsQuery, [email], async (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Database query error');
        }

        if (results.length > 0) {
            return res.status(409).send('Email already exists!');
        }

        try {
            // 비밀번호 해시 생성
            const hashedPassword = await bcrypt.hash(password, 10);

            // 데이터베이스에 사용자 정보 저장
            const insertQuery = 'INSERT INTO TeamMembers (Name, Email, PhoneNumber, Position, PasswordHash) VALUES (?, ?, ?, ?, ?)';
            db.query(insertQuery, [name, email, phoneNumber, position, hashedPassword], (err, results) => {
                if (err) {
                    console.error(err);
                    return res.status(500).send('Error saving user to database.');
                }
                res.status(201).send('User created successfully.');
            });
        } catch (err) {
            res.status(500).send('Error creating user.');
        }
    });
});




// 로그인 라우트
router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).send('Email and password are required.');
    }

    try {
        // 데이터베이스에서 사용자 조회
        const query = 'SELECT * FROM TeamMembers WHERE Email = ?';
        db.query(query, [email], async (err, users) => {
            if (err) {
                console.error(err);
                return res.status(500).send('Error retrieving user from database.');
            }

            const user = users[0];
            if (user && await bcrypt.compare(password, user.PasswordHash)) {
                // JWT 토큰 생성
                const token = jwt.sign({ email: user.Email, id: user.MemberID }, JWT_SECRET);
                res.json({ token });
            } else {
                res.status(401).send('Invalid login credentials.');
            }
        });
    } catch (err) {
        res.status(500).send('Login error.');
    }
});


module.exports = router;
