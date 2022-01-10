const User = require("../model/user");

module.exports.getAllUser = async (req, res) => {

    let users = await User.find();

    res.send(users);
};