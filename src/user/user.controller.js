const login = (request, response, next) => {
    const { username, password } = request.body;

    console.log({
        username,
        password,
    });

    response.json({ token: "432lkjd,asljsalkjlkd-" });
};

module.exports = { login };