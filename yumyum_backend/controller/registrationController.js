const User = require("../model/user");

module.exports.register = async (req, res) => {
  const { name, username, password, address, email } = req.body;

  let user = new User();
  user.name = name;
  user.username = username;
  user.password = password;
  user.address = address;
  user.email = email;
  user.profileImage = '';

  user.save();

  res.json({ isRegistered: 1 });
};
