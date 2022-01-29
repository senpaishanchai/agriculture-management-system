const select = (type) => {
    switch (type) {
        case "all_users":
            return `SELECT * FROM userInfo`;
        case "one_user":
            return `SELECT * FROM user WHERE userName = ?`;
        case "login":
            return `SELECT * FROM user WHERE userName = ? && password = ?`;
        case "register":
            return `INSERT INTO user(userName, password, mobileNumber) VALUES(?, ?, ?)`;
        default:
            return 0;
    }
};

module.exports = { select };