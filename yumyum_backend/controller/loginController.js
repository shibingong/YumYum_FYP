const User = require("../model/user");
require("dotenv").config();
const jwt = require("jsonwebtoken");

module.exports.checkCredential = async (req, res) => {
    const { username, password } = req.body;

    const user = await User.findOne({ username: username, password: password });
    if (user != null) {
        const token = jwt.sign({ id: user._id }, "yumyumfyp");
        res.json({ loginStatus: 1, jwt: token });
    } else {
        res.json({ loginStatus: 0 });
    }
};

module.exports.adminLogin = async (req, res) => {
    const { username, password } = req.body;

    const user = await User.findOne({ username: username, password: password });
        const token = jwt.sign({ id: user._id }, "yumyumfyp");
        res.json({ token: token });
};