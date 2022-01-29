const connection = require("../config/database");
const { select } = require("../helpers/queries/select.query");

const login = async(request, response, next) => {
    try {
        const { userName, password } = request.body;

        const queryLogin = select("login");
        const user = [userName, password];

        const result = await connection(queryLogin, user);

        response.json({ result });
    } catch (err) {
        console.log(err);
    }
};

const register = async(request, response, next) => {
    try {
        const { userName, password, mobileNumber } = request.body;

        const queryRegister = select("register");
        const queryOneUser = select("one_user");
        const newUser = [userName, password, mobileNumber];

        const isAlreadyRegistered = await connection(queryOneUser, newUser);
        const newUserResult = await connection(queryRegister, newUser);

        if (isAlreadyRegistered.length) {
            response.json({
                message: "Username is already taken.",
                isAlreadyRegistered: isAlreadyRegistered,
            });
        } else {
            response.json({ newUserResult });
        }
    } catch (error) {
        console.log(error);
    }
};

module.exports = { login, register };