const jwt = require("jwt");

const authorize = (roles = []) => {
    if (typeof roles === "string") roles = [roles];

    return [
        async(req, res, next) => {
            // const account = await database;
        },
    ];
};

module.exports = authorize;