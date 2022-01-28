const mysql = require("mysql");

const databaseConfig = {
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
};

const db = mysql.createPool(databaseConfig);

const database = (query) => {
    return new Promise((resolve, reject) => {
        db.getConnection((err, sql) => {
            if (err) {
                console.log("Database error: ", err);
                reject(err);
            } else {
                sql.query(query, (err, results) => {
                    if (err) {
                        console.log("Query error: ", err);
                        reject(err);
                    } else {
                        resolve(results);
                    }

                    sql.release();
                });
            }
        });
    });
};

module.exports = database;