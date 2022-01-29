const mysql = require("mysql");

const databaseConfig = {
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
};

const pool = mysql.createPool(databaseConfig);

const connection = (query, data) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, sql) => {
            if (err) {
                console.log(`❌ Error Connecting to Database `);
                reject(err);
            } else {
                console.log(`✔ Database Connected Successfully!`);

                if (query) {
                    sql.query(query, [...data], (err, results) => {
                        if (err) {
                            console.log(`Query error: ${err}`);
                            reject(err);
                        } else resolve(results);

                        sql.release();
                    });
                }
            }
        });
    });
};

module.exports = connection;