require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");

/* Import Routes */
const authRoute = require("./user/user.route");

/* App */
const app = express();

/* Middleware */
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.json());

/* Routes */
app.use("/", authRoute);

/* Server */
app.listen(process.env.PORT, () =>
    console.log(`✅ http://localhost:${process.env.PORT}`)
);