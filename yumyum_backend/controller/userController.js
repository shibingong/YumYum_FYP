const User = require("../model/user");
const Recipe = require("../model/recipe");
var fs = require('fs');

module.exports.getAllUser = async (req, res) => {
  let users = await User.find({_id:{$ne:"628afb4ad3bd5fa4b26a6b6e"} });
  res.json(users);
};

module.exports.getUser = async (req, res) => {
  const host = req.headers.host;
  const id = req.id;
  const user = await User.findById(id);
  if (user.profileImage !== "" && !user.profileImage.includes('http'))
    user.profileImage = `http://${host}/images/${user.profileImage}`;
  res.json(user);
};

module.exports.getUserById = async (req, res) => {
  const host = req.headers.host;
  const id = req.params["id"];
  const user = await User.findById(id);
  if (user.profileImage !== "" && !user.profileImage.includes('http'))
    user.profileImage = `http://${host}/images/${user.profileImage}`;
  res.json(user);
};

module.exports.updateUser = async (req, res) => {
  const id = req.id;
  const newUserData = req.body;

  const user = await User.findByIdAndUpdate(id, newUserData, {
    new: true,
    useFindAndModify: false,
  });
  res.json(user);
};

module.exports.updateUserById = async (req, res) => {
  const id = req.params["id"];
  const newUserData = req.body;

  const user = await User.findByIdAndUpdate(id, newUserData, {
    new: true,
    useFindAndModify: false,
  });
  res.json(user);
};

module.exports.uploadImage = async (req, res) => {
  const host = req.headers.host;
  const id = req.id;
  const { image, name } = req.body;
  var realFile = Buffer.from(image, "base64");
  fs.writeFile("public/images/" + name, realFile, function (err) {
    if (err) console.log(err);
  });
  await User.findByIdAndUpdate(
    id,
    { profileImage: name },
    { new: true, useFindAndModify: false }
  );
  res.json(`http://${host}/images/${name}`);
};

module.exports.deleteUserById = async (req, res) => {
  const userid = req.params["id"];
  await User.findByIdAndDelete(userid);
  await Recipe.deleteMany({ userID: userid });
  res.send("deleted");
};