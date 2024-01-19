const bcrypt = require('bcrypt');

const password = '2331';
const saltRounds = 10;

bcrypt.hash(password, saltRounds, function(err, hash) {
    if (err) {
        console.error(err);
        return;
    }
    console.log("Generated hash:", hash);
});
